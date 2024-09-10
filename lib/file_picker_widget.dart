import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:vfs_dynamic_app/data/model/app_config_new.dart';
import 'package:vfs_dynamic_app/data/model/file_model.dart';
import 'package:vfs_dynamic_app/data/utils/logger.dart';
import 'package:vfs_dynamic_app/data/utils/size_config.dart';

class FilePickerWidget extends StatefulWidget {
  final Field componentData;
  int index;
  Function(FileModel file) onFilePicked;

  FilePickerWidget(
      {super.key,
      required this.componentData,
      required this.onFilePicked,
      required this.index});

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  bool filePicked = false;
  Uint8List? selectedFileBytes;
  String? selectedFileType;
  String? pdfPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.componentData.label!),
          subtitle: TextButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: widget.componentData.validation?.fileTypes,
              );

              if (result != null) {
                PlatformFile file = result.files.first;
                double size = file.size / 1024;
                double? maxSize =
                    widget.componentData.validation!.maxSizeInKb?.toDouble();
                if (size > maxSize!) {
                  const snackBar = SnackBar(
                    content: Text('Size should be less than 200KB'),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  widget
                      .onFilePicked(FileModel(file: file, index: widget.index));
                  setState(() {
                    Logger.doLog("FILE UPLOADED....");
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
  }
}
