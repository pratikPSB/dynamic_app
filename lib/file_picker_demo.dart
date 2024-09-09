import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:vfs_dynamic_app/data/model/app_config_new.dart';
import 'package:vfs_dynamic_app/data/utils/size_config.dart';

class FilePickerDemo extends StatefulWidget {
  final String title;
  final List<Field> fields;
  const FilePickerDemo({super.key, required this.title, required this.fields});

  @override
  State<FilePickerDemo> createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  Uint8List? selectedFileBytes;
  String? selectedFileType;
  String? pdfPath;

  // DynamicAppConfigModel appConfigModel = DynamicAppConfigModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          ListTile(
            title: Text(widget.fields[0].label!),
            subtitle: TextButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: widget.fields[0].validation?.fileTypes,
                );

                if (result != null) {
                  PlatformFile file = result.files.first;
                  double size = file.size / 1024;
                  double? maxSize = widget.fields[0].validation!.maxSizeInKb?.toDouble();
                  if (size > maxSize!) {
                    const snackBar = SnackBar(
                      content: Text('Size should be less than 200KB'),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    setState(() {
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
          const SizedBox(height: 10),
          FilledButton(
            onPressed: () {},
            child: const Text("Save and Continue"),
          ),
        ],
      ),
    );
  }
}
