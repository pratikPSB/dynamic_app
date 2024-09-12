import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:vfs_dynamic_app/data/model/app_screens_model.dart';
import 'package:vfs_dynamic_app/data/model/file_model.dart';
import 'package:vfs_dynamic_app/data/utils/logger.dart';
import 'package:vfs_dynamic_app/data/utils/size_config.dart';

class FilePickerWidget extends StatefulWidget {
  final Field componentData;
  final Function(FileModel file) onFilePicked;
  final int index;

  const FilePickerWidget(
      {super.key, required this.componentData, required this.onFilePicked, required this.index});

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(widget.componentData.label!),
            subtitle: TextButton(
              onPressed: () async {
                FilePickerResult? result = (await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: widget.componentData.validation?.fileTypes,
                ));
      
                if (result != null) {
                  if (result.isSinglePick) {
                    PlatformFile file = result.files.first;
                    double size = file.size / 1024;
                    double? maxSize = widget.componentData.validation!.maxSizeInKb?.toDouble();
                    if (size > maxSize!) {
                      var snackBar = SnackBar(
                        content: Text(
                            'Size should be less than ${widget.componentData.validation!.maxSizeInKb}KB'),
                        duration: const Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      widget.onFilePicked(FileModel(file: file, index: widget.index));
                      setState(() {
                        Logger.doLog("FILE UPLOADED....");
                        filePicked = true;
                        selectedFileBytes = file.bytes;
                        selectedFileType = file.extension;
                        pdfPath = kIsWeb ? null : file.path;
                        Logger.doLog("FILE UPLOADED.... $pdfPath $selectedFileType");
                      });
                    }
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
              child: (selectedFileType == 'jpg' || selectedFileType == 'png')
                  ? kIsWeb
                      ? Image.memory(
                          selectedFileBytes!,
                          alignment: Alignment.bottomLeft,
                          fit: BoxFit.fitHeight,
                        )
                      : Image.file(
                          File(pdfPath!),
                          alignment: Alignment.bottomLeft,
                          fit: BoxFit.fitHeight,
                        )
                  : (selectedFileType == 'pdf')
                      ? kIsWeb
                          ? SfPdfViewer.memory(
                              selectedFileBytes!,
                            )
                          : SfPdfViewer.file(
                              File(pdfPath!),
                            )
                      : const Text("No PDF selected"),
            ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
