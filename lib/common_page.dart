import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:vfs_dynamic_app/data/utils/extensions.dart';
import 'package:vfs_dynamic_app/data/utils/size_config.dart';
import 'package:vfs_dynamic_app/data/utils/validations.dart';

import 'data/model/app_config_new.dart';

class CommonPage extends StatefulWidget {
  final String title;
  final Screen screenData;

  const CommonPage({super.key, required this.title, required this.screenData});

  @override
  State<CommonPage> createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {
  final formKey = GlobalKey<FormState>();
  bool filePicked = false;
  Uint8List? selectedFileBytes;
  String? selectedFileType;
  String? pdfPath;

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
                    return buildComponent(widget.screenData.fields![index]);
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

  Widget buildComponent(Field componentData) {
    switch (componentData.type) {
      case "edit_text":
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (text) =>
                validateEditText(text, componentData.validation!),
            decoration: InputDecoration(
              labelText: (!componentData.required!)
                  ? "${componentData.label} *"
                  : componentData.label,
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
        return Column(
          children: [
            ListTile(
              title: Text(componentData.label!),
              subtitle: TextButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: componentData.validation?.fileTypes,
                  );

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    double size = file.size / 1024;
                    double? maxSize =
                        componentData.validation!.maxSizeInKb?.toDouble();
                    if (size > maxSize!) {
                      const snackBar = SnackBar(
                        content: Text('Size should be less than 200KB'),
                        duration: Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      print("FILE UPLOADED");
                      setState(() {
                        print("FILE UPLOADED....");
                        filePicked = true;
                        selectedFileBytes = file.bytes;
                        selectedFileType = file.extension;
                        pdfPath = kIsWeb ? null : file.path;
                      });
                    }
                  }
                },
                child: const Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: Text("UPLOAD FILE"),
                ),
              ),
            ),
            if (filePicked)
              SizedBox(
                height: 0.3 * SizeConfig.screenHeight,
                width: double.infinity,
                child: selectedFileType == 'jpg' || selectedFileType == 'png'
                    ? selectedFileBytes != null
                        ? Image.memory(
                            selectedFileBytes!,
                            alignment: Alignment.bottomLeft,
                            fit: BoxFit.fitHeight,
                          )
                        : const SizedBox()
                    : selectedFileType == 'pdf'
                        ? selectedFileBytes != null
                            ? kIsWeb
                                ? SfPdfViewer.memory(selectedFileBytes!)
                                : SfPdfViewer.file(File(pdfPath!))
                            : const Text("No PDF selected")
                        : const SizedBox(),
              ),
            const SizedBox(height: 10)
          ],
        );
      // return Container();
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

  TextInputAction _getActionType(String inputType) {
    switch (inputType) {
      case 'action_next':
        return TextInputAction.next;
      case 'action_done':
      default:
        return TextInputAction.done;
    }
  }

  Widget buildTextEntities(Field componentData) {
    switch (componentData.type) {
      default:
        return Container();
    }
  }
}
