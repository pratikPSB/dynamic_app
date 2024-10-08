import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fading_marquee_widget/fading_marquee_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:vfs_dynamic_app/data/model/app_modules_by_client_model.dart';
import 'package:vfs_dynamic_app/data/model/country_response_model.dart';
import 'package:vfs_dynamic_app/data/model/file_model.dart';
import 'package:vfs_dynamic_app/data/model/gender_res_model.dart';
import 'package:vfs_dynamic_app/data/utils/date_helper.dart';
import 'package:vfs_dynamic_app/data/utils/extensions.dart';
import 'package:vfs_dynamic_app/data/utils/logger.dart';
import 'package:vfs_dynamic_app/data/utils/validations.dart';
import 'package:vfs_dynamic_app/main.dart';

import '../data/model/text_controller_model.dart';
import '../data/services/api_service/api_result.dart';
import '../data/services/api_service/local_end_api_service.dart';

class CommonPage extends StatefulWidget {
  final String title;
  final Module screenData;

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
  final List<String> defaultDropDownList = ["Loading..."];
  final Map<String, dynamic> jsonData = {};

  @override
  void initState() {
    super.initState();
    callInitialAPIs();
    widget.screenData.controls?.forEachIndexed((parentIndex, row) {
      widget.screenData.controls![parentIndex].fields!.forEachIndexed(
        (index, element) {
          if (element.optionsListApi != null) {
            callFieldAPI(element.optionsListApi!, element.defaultValueOptionSet);
          }
        },
      );
    });
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
        title: FadingMarqueeWidget(
          pause: const Duration(milliseconds: 0),
          child: Text(widget.title),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: widget.screenData.controls!.length,
                  (context, index) {
                    return buildRow(widget.screenData.controls![index], index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildTextControllerList(int parentIndex, int index) {
    var fieldType = widget.screenData.controls![parentIndex].fields![index];
    if (fieldType.fieldType == "textbox" ||
        fieldType.fieldType == "searchable-dropdown" ||
        fieldType.fieldType == "datepicker") {
      if (fieldType.fieldType == "searchable-dropdown") {
        if (fieldType.defaultValueOptionSet!.isEmpty) {
          fieldType.defaultValueOptionSet?.add("Loading ${fieldType.displayName}");
        }
        textControllerList.add(
          TextControllerModel(
            controller: TextEditingController(
              text: fieldType.defaultValueOptionSet![0],
            ),
            elementName: fieldType.logicalName!,
            parentIndex: parentIndex,
            index: index,
          ),
        );
      } else {
        textControllerList.add(
          TextControllerModel(
            controller: TextEditingController(
                text: fieldType.defaultValueOptionSet!.isNotEmpty
                    ? fieldType.defaultValueOptionSet![0]
                    : ""),
            elementName: fieldType.logicalName!,
            parentIndex: parentIndex,
            index: index,
          ),
        );
      }
    }
  }

  Widget buildRow(Control componentData, int parentIndex) {
    var list = componentData.fields!;
    return Row(
      children: list.mapIndexed<Widget>(
        (index, field) {
          buildTextControllerList(parentIndex, index);
          return Expanded(
              child: buildComponent(field, parentIndex, index, componentData.mandatory));
        },
      ).toList(),
    );
  }

  Widget buildComponent(FieldElement componentData, int parentIndex, int index, bool? mandatory) {
    switch (componentData.fieldType) {
      case "textbox":
      case "datepicker":
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: textControllerList
                .lastWhere(
                    (element) => (element.index == index && element.parentIndex == parentIndex))
                .controller,
            readOnly: componentData.fieldType == "datepicker",
            onTap: (componentData.fieldType == "datepicker")
                ? () async {
                    performHapticFeedback();
                    DateTime? pickedDate = await DateHelper.commonPickedDate(context);
                    textControllerList
                        .lastWhere((element) =>
                            (element.index == index && element.parentIndex == parentIndex))
                        .controller
                        .text = DateHelper.convertDateString(
                      pickedDate.toString(),
                      DateHelper.dfdmyhms,
                      DateHelper.dfddmmyyyy,
                    );
                  }
                : null,
            validator: (text) => (mandatory != null)
                ? (!mandatory)
                    ? null
                    : validateEditText(text, componentData.validations!)
                : null,
            decoration: InputDecoration(
              labelText: (mandatory != null)
                  ? (mandatory)
                      ? "${componentData.displayName} *"
                      : componentData.displayName
                  : componentData.displayName,
              border: OutlineInputBorder(
                borderRadius: 10.modifyCorners(),
                borderSide: BorderSide(
                  color: context.getTheme().primaryColor,
                ),
              ),
              hintText: componentData.displayName,
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
        );
      case 'searchable-dropdown':
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownSearch<dynamic>(
            decoratorProps: DropDownDecoratorProps(
              decoration: InputDecoration(
                border: context.getTheme().inputDecorationTheme.border!,
              ),
            ),
            clickProps: ClickProps(borderRadius: BorderRadius.circular(15)),
            selectedItem: componentData.defaultValueOptionSet![0],
            compareFn: (item1, item2) {
              return item1 == item2;
            },
            items: (filter, loadProps) {
              return componentData.defaultValueOptionSet!;
            },
            onChanged: (value) {
              textControllerList.lastWhere((element) => (element.index == index)).controller.text =
                  value!;
            },
            popupProps: PopupProps.menu(
              fit: FlexFit.loose,
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                border: context.getTheme().inputDecorationTheme.border!,
              )),
              menuProps: MenuProps(
                borderRadius: 15.modifyCorners(),
              ),
            ),
          ),
        );
      case "button":
        return buildButton(componentData);
      default:
        return Container();
    }
  }

  buildButton(FieldElement componentData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FilledButton(
        onPressed: () {
          performHapticFeedback();
          handleButtonPress(componentData);
        },
        child: FadingMarqueeWidget(
          pause: const Duration(milliseconds: 0),
          child: Text(
            componentData.displayName!,
          ),
        ),
      ),
    );
  }

  handleButtonPress(FieldElement componentData) async {
    if (formKey.currentState!.validate()) {
      if (componentData.validations != null) {
        fillJsonData();
        // context.pop();
        if (componentData.onClickEvent != null) {
          for (var element in componentData.onClickEvent!) {
            fillJsonData();
            if (jsonData.isNotEmpty) {
              ApiResult<dynamic> response1 = await ApiService.getApiService(mockServerService)
                  .postApiCall(element.url!, jsonData);
              Fluttertoast.showToast(msg: response1.data, toastLength: Toast.LENGTH_LONG);
              Logger.doLog("RESPONSE : ${response1.data}");
            }
          }
        }
        context.pop();
      }
    }
  }

  void fillJsonData() {
    if (textControllerList.isNotEmpty) {
      for (var control in widget.screenData.controls!) {
        for (var field in control.fields!) {
          if (field.fieldType == "textbox" ||
              field.fieldType == "searchable-dropdown" ||
              field.fieldType == "datepicker") {
            for (var element in textControllerList) {
              if (element.elementName == field.logicalName!) {
                Logger.doLog("${field.logicalName!} : ${element.controller.text}");
                jsonData[field.logicalName!] = element.controller.text;
              }
            }
          }
        }
      }
    }
  }

  callInitialAPIs() async {
    for (Online pageLoad in widget.screenData.apis!.online!) {
      switch (pageLoad.type) {
        case "GET":
          ApiResult<dynamic> response =
              await ApiService.getApiService(liveServerService).getApiCall(
            pageLoad.url!,
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
            // for (Control control in widget.screenData.controls!) {
            //   for(FieldElement field in control.fields!) {
            //     if (field.logicalName == pageLoad.targetField) {
            //       switch (field.logicalName) {
            //         case "searchable-dropdown":
            //           setState(() {
            //             field.defaultValueOptionSet = countryNames;
            //           });
            //           break;
            //       }
            //       break;
            //     }
            //   }
            // }
          } else if (response.getException != null) {
            Logger.doLog("CountrySelectionController : initState");
          }
      }
    }
  }

  callFieldAPI(OptionsListApi options, List<dynamic>? defaultValueOptionSet) {
    if (options.backoffice != null) {
      callBackOfficeApi(options.backoffice!, defaultValueOptionSet);
    } else if (options.online != null) {
      callBackOfficeApi(options.online!, defaultValueOptionSet);
    }
  }

  Future<void> callBackOfficeApi(
      Backoffice backoffice, List<dynamic>? defaultValueOptionSet) async {
    if (backoffice.type == "GET") {
      ApiResult<dynamic> response = await ApiService.getApiService(mockServerService).getApiCall(
        backoffice.url!,
        showLoaderDialog: true,
      );
      if (response.data != null) {
        GenderResModel model = genderResModelFromJson(response.data);
        var tempList = List<String>.empty(growable: true);
        for (var element in model.data!) {
          if (!defaultValueOptionSet!.contains(element.name)) {
            tempList.add(element.name!);
          }
        }
        if (tempList.isNotEmpty) {
          setState(() {
            defaultValueOptionSet!.addAll(tempList);
          });
        }
      }
    }
  }
}
