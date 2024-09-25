import 'package:flutter/cupertino.dart';

class TextControllerModel {
  final TextEditingController controller;
  final String elementName;
  final int parentIndex;
  final int index;

  TextControllerModel({required this.controller,required this.elementName, required this.parentIndex, required this.index});
}
