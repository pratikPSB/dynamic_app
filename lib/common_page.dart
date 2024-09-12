import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vfs_dynamic_app/data/model/country_response_model.dart';
import 'package:vfs_dynamic_app/data/model/file_model.dart';
import 'package:vfs_dynamic_app/data/utils/extensions.dart';
import 'package:vfs_dynamic_app/data/utils/logger.dart';
import 'package:vfs_dynamic_app/data/utils/size_config.dart';
import 'package:vfs_dynamic_app/data/utils/validations.dart';
import 'package:vfs_dynamic_app/file_picker_widget.dart';
import 'package:vfs_dynamic_app/main.dart';

import 'data/model/app_screens_model.dart';
import 'data/model/text_controller_model.dart';
import 'data/services/api_service/api_result.dart';
import 'data/services/api_service/local_end_api_service.dart';

class CommonPage extends StatefulWidget {
  final String title;
  final Screen screenData;

  const CommonPage({
    super.key,
    required this.title,
    required this.screenData,
  });

  @override
  State<CommonPage> createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {
  final formKey = GlobalKey<FormState>();
  final List<FileModel> fileList = [];
  final List<TextControllerModel> textControllerList = [];
  final Map<String, dynamic> jsonData = {};

  @override
  void initState() {
    super.initState();
    callInitialAPIs();
  }

  @override
  void dispose() {
    for (TextControllerModel controller in textControllerList) {
      controller.controller.dispose();
    }
    textControllerList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textControllerList.clear();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: widget.screenData.fields!.length,
                  (context, index) {
                    buildTextControllerList(index);
                    return buildComponent(widget.screenData.fields![index], index);
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: widget.screenData.buttons!.length,
                  (context, index) {
                    return buildButton(widget.screenData.buttons![index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildTextControllerList(int index) {
    if (widget.screenData.fields![index].type == "edit_text" ||
        widget.screenData.fields![index].type == "drop_down") {
      if (widget.screenData.fields![index].type == "drop_down") {
        textControllerList.add(
          TextControllerModel(
            controller: TextEditingController(
                text: widget.screenData.fields![index].options![0]),
            elementName: widget.screenData.fields![index].name!,
            index: index,
          ),
        );
      } else {
        textControllerList.add(
          TextControllerModel(
            controller: TextEditingController(),
            elementName: widget.screenData.fields![index].name!,
            index: index,
          ),
        );
      }
    }
  }

  Widget buildComponent(Field componentData, int index) {
    switch (componentData.type) {
      case "edit_text":
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller:
                textControllerList.lastWhere((element) => (element.index == index)).controller,
            validator: (text) => (!componentData.required!)
                ? null
                : validateEditText(text, componentData.validation!),
            decoration: InputDecoration(
              labelText:
                  (componentData.required!) ? "${componentData.label} *" : componentData.label,
              border: OutlineInputBorder(
                borderRadius: 10.modifyCorners(),
                borderSide: BorderSide(
                  color: context.getTheme().primaryColor,
                ),
              ),
              hintText: componentData.label,
            ),
            keyboardType: _getInputType(componentData.inputType!),
            textInputAction: TextInputAction.next,
          ),
        );
      case "text":
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(componentData.label!),
        );
      case 'drop_down':
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            menuMaxHeight: SizeConfig.screenHeight * 0.33,
            value: componentData.options![0],
            items: (componentData.options!)
                .map((value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
            onChanged: (value) {
              textControllerList.lastWhere((element) => (element.index == index)).controller.text =
                  value!;
            },
          ),
        );
      case 'file':
        return FilePickerWidget(
          componentData: componentData,
          index: index,
          onFilePicked: (file) {
            for (FileModel fileModel in fileList) {
              if (fileModel.index == file.index) {
                fileList.remove(fileModel);
                break;
              }
            }
            fileList.add(file);
            jsonData[componentData.name!] = file.file.name;
            Logger.doLog("${fileList.length}");
          },
        );
      default:
        return Container();
    }
  }

  buildButton(Button componentData) {
    switch (componentData.type) {
      case "filled_button":
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
            onPressed: () {
              performHapticFeedback();
              handleButtonPress(componentData);
            },
            child: Text(
              componentData.label!,
            ),
          ),
        );
      case "outlined_button":
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            onPressed: () {
              performHapticFeedback();
              handleButtonPress(componentData);
            },
            child: Text(
              componentData.label!,
            ),
          ),
        );
      case "text_button":
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              performHapticFeedback();
              handleButtonPress(componentData);
            },
            child: Text(
              componentData.label!,
            ),
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              performHapticFeedback();
              handleButtonPress(componentData);
            },
            child: Text(
              componentData.label!,
              style: TextStyle(color: context.getColorScheme().onPrimary),
            ),
          ),
        );
    }
  }

  handleButtonPress(Button componentData) async {
    if (formKey.currentState!.validate()) {
      if (componentData.navigationOnSuccess != null) {
        if (componentData.apiEndPoint != "" && componentData.apiEndPoint != "") {
          if (componentData.method == "POST") {
            fillJsonData();
            if (jsonData.isNotEmpty) {
              ApiResult<dynamic> response1 = await LocalApiService.getApiService(mockServerService)
                  .postApiCall(componentData.apiEndPoint!, jsonData);
              Logger.doLog("RESPONSE : ${response1.data}");
            }
          }
        }
        context.push(componentData.navigationOnSuccess!);
      }
    }
  }

  void fillJsonData() {
    if (textControllerList.isNotEmpty) {
      for (var field in widget.screenData.fields!) {
        if (field.type == "edit_text" || field.type == "drop_down") {
          for (var element in textControllerList) {
            if (element.elementName == field.name!) {
              jsonData[field.name!] = element.controller.text;
            }
          }
        }
      }
    }
  }

  TextInputType _getInputType(String inputType) {
    switch (inputType) {
      case 'email_address':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.phone;
      default:
        return TextInputType.text;
    }
  }

  callInitialAPIs() async {
    for (On pageLoad in widget.screenData.onPageLoad!) {
      switch (pageLoad.method) {
        case "GET":
          ApiResult<dynamic> response =
              await LocalApiService.getApiService(liveServerService).getApiCall(
            pageLoad.apiEndPoint!,
            showLoaderDialog: true,
          );
          if (response.data != null) {
            CountryResponseModel model = countryResponseModelFromJson(response.data!);
            List<String> countryNames = [];
            for (var country in model.extraData!) {
              if (!country.isDeleted!) {
                countryNames.add(country.countryName!);
              }
            }
            for (Field field in widget.screenData.fields!) {
              if (field.name == pageLoad.targetField) {
                switch (field.type) {
                  case "drop_down":
                    setState(() {
                      field.options = countryNames;
                    });
                    break;
                }
                break;
              }
            }
          } else if (response.getException != null) {
            Logger.doLog("CountrySelectionController : initState");
          }
      }
    }
  }
}
