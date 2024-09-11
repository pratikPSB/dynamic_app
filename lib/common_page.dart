import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vfs_dynamic_app/data/model/country_response_model.dart';
import 'package:vfs_dynamic_app/data/model/file_model.dart';
import 'package:vfs_dynamic_app/data/utils/extensions.dart';
import 'package:vfs_dynamic_app/data/utils/logger.dart';
import 'package:vfs_dynamic_app/data/utils/size_config.dart';
import 'package:vfs_dynamic_app/data/utils/validations.dart';
import 'package:vfs_dynamic_app/file_picker_widget.dart';

import 'data/model/app_screens_model.dart';
import 'data/services/api_service/api_result.dart';
import 'data/services/api_service/local_end_api_service.dart';

class CommonPage extends StatefulWidget {
  final String title;
  final Screen screenData;
  final List<FileModel> fileList = [];

  CommonPage({
    super.key,
    required this.title,
    required this.screenData,
  });

  @override
  State<CommonPage> createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    callInitialAPIs();
  }

  @override
  Widget build(BuildContext context) {
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

  Widget buildComponent(Field componentData, int index) {
    switch (componentData.type) {
      case "edit_text":
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (text) => validateEditText(text, componentData.validation!),
            decoration: InputDecoration(
              labelText:
                  (!componentData.required!) ? "${componentData.label} *" : componentData.label,
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
        return Text(componentData.label!);
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
            onChanged: (value) {},
          ),
        );
      case 'file':
        return FilePickerWidget(
          componentData: componentData,
          index: index,
          onFilePicked: (file) {
            for (FileModel fileModel in widget.fileList) {
              if (fileModel.index == file.index) {
                widget.fileList.remove(fileModel);
                break;
              }
            }
            widget.fileList.add(file);
            Logger.doLog("${widget.fileList.length}");
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

  handleButtonPress(Button componentData) {
    if (formKey.currentState!.validate()) {
      if (componentData.navigationOnSuccess != null) {
        context.push(componentData.navigationOnSuccess!);
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
              await LocalApiService().getApiCall(pageLoad.apiEndPoint!, showLoaderDialog: true);
          if (response.data != null) {
            CountryResponseModel model = countryResponseModelFromJson(response.data!);
            List<String> countryNames = [];
            model.extraData!.forEach((country) {
              if (!country.isDeleted!) {
                countryNames.add(country.countryName!);
              }
            });
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
