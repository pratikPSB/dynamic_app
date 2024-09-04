import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vfs_dynamic_app/data/model/app_config.dart' hide TextStyle;
import 'package:vfs_dynamic_app/data/utils/extensions.dart';
import 'package:vfs_dynamic_app/data/utils/size_config.dart';
import 'package:vfs_dynamic_app/data/utils/validations.dart';

class CommonPage extends StatefulWidget {
  final String title;
  final List<Field> fields;

  const CommonPage({super.key, required this.title, required this.fields});

  @override
  State<CommonPage> createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {
  final formKey = GlobalKey<FormState>();

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
                  childCount: widget.fields.length,
                  (context, index) {
                    return buildComponent(widget.fields[index]);
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
    switch (componentData.component) {
      case 'TextBox':
        return buildTextEntities(componentData);
      case 'DropDown':
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            menuMaxHeight: SizeConfig.screenHeight * 0.33,
            value: componentData.valueList![0],
            items: (componentData.valueList!)
                .map((value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
            onChanged: (value) {},
          ),
        );
      case 'Row':
        return Row(
          children: componentData.childComponents!
              .map(
                (child) => (child.isExpanded == true)
                    ? Expanded(child: buildComponent(child))
                    : (child.style!.width! != 0)
                        ? SizedBox(
                            width: SizeConfig.widthMultiplier * child.style!.width!,
                            child: buildComponent(child),
                          )
                        : buildComponent(child),
              )
              .toList(),
        );
      case 'ListView':
        return ListView(
          shrinkWrap: true,
          children: componentData.valueList!.map(
            (child) {
              return buildComponent(child);
            },
          ).toList(),
        );
      case 'ListItem':
        return ListTile(
          leading: (componentData.leading != null) ? buildComponent(componentData.leading!) : null,
          trailing:
              (componentData.trailing != null) ? buildComponent(componentData.trailing!) : null,
          title: buildComponent(componentData.title!),
          subtitle: buildComponent(componentData.subtitle!),
        );
      case 'Image':
        return getImage(componentData);
      case 'Button':
        return getButton(componentData);
      default:
        return Container();
    }
  }

  Widget getImage(Field componentData) {
    switch (componentData.type) {
      case "asset":
        return SizedBox(
          width: (componentData.style!.width! != 0)
              ? SizeConfig.imageSizeMultiplier * componentData.style!.width!.toDouble()
              : SizeConfig.imageSizeMultiplier * componentData.style!.size!.toDouble(),
          height: (componentData.style!.height! != 0)
              ? SizeConfig.imageSizeMultiplier * componentData.style!.height!.toDouble()
              : SizeConfig.imageSizeMultiplier * componentData.style!.size!.toDouble(),
          child: SvgPicture.asset(
            componentData.path!,
          ),
        );
      case "network":
        return SizedBox(
          width: (componentData.style!.width! != 0)
              ? SizeConfig.imageSizeMultiplier * componentData.style!.width!.toDouble()
              : SizeConfig.imageSizeMultiplier * componentData.style!.size!.toDouble(),
          height: (componentData.style!.height! != 0)
              ? SizeConfig.imageSizeMultiplier * componentData.style!.height!.toDouble()
              : SizeConfig.imageSizeMultiplier * componentData.style!.size!.toDouble(),
          child: SvgPicture.network(
            componentData.path!,
          ),
        );
      default:
        return const SizedBox(
          height: 5,
          width: 5,
        );
    }
  }

  getButton(Field componentData) {
    switch (componentData.type) {
      case "filled_button":
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
            style: (componentData.style!.decorationColor != null)
                ? FilledButton.styleFrom(
                    backgroundColor: Color(
                      componentData.style!.decorationColor!.getColorHexFromStr(),
                    ),
                  )
                : FilledButton.styleFrom(),
            onPressed: () {
              performHapticFeedback();
              handleButtonPress(componentData);
            },
            child: Text(
              componentData.text!,
            ),
          ),
        );
      case "outlined_button":
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            style: (componentData.style!.decorationColor != null)
                ? OutlinedButton.styleFrom(
                    backgroundColor: Color(
                      componentData.style!.decorationColor!.getColorHexFromStr(),
                    ),
                  )
                : OutlinedButton.styleFrom(),
            onPressed: () {
              performHapticFeedback();
              handleButtonPress(componentData);
            },
            child: Text(
              componentData.text!,
            ),
          ),
        );
      case "text_button":
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            style: (componentData.style!.decorationColor != null)
                ? TextButton.styleFrom(
                    backgroundColor: Color(
                      componentData.style!.decorationColor!.getColorHexFromStr(),
                    ),
                  )
                : TextButton.styleFrom(),
            onPressed: () {
              performHapticFeedback();
              handleButtonPress(componentData);
            },
            child: Text(
              componentData.text!,
            ),
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: (componentData.style!.decorationColor != null)
                ? ElevatedButton.styleFrom(
                    backgroundColor: Color(
                      componentData.style!.decorationColor!.getColorHexFromStr(),
                    ),
                  )
                : ElevatedButton.styleFrom(),
            onPressed: () {
              performHapticFeedback();
              handleButtonPress(componentData);
            },
            child: Text(
              componentData.text!,
              style: TextStyle(color: context.getColorScheme().onPrimary),
            ),
          ),
        );
    }
  }

  handleButtonPress(Field componentData) {
    if (formKey.currentState!.validate()) {
      if (componentData.callApi == true) {}
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
    switch (componentData.uiComponent) {
      case "edit_text":
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (text) => validateEmail(text),
            decoration: InputDecoration(
              labelText:
                  (!componentData.isOptional!) ? "${componentData.label} *" : componentData.label,
              border: OutlineInputBorder(
                borderRadius: 10.modifyCorners(),
                borderSide: BorderSide(
                  color: context.getTheme().primaryColor,
                ),
              ),
              hintText: componentData.hint,
            ),
            keyboardType: _getInputType(componentData.inputType!),
            textInputAction: _getActionType(componentData.actionType!),
          ),
        );
      case "text":
        return Text(componentData.text!);
      case "text_span":
        return RichText(
            text:
                TextSpan(text: componentData.text!, recognizer: TapGestureRecognizer()..onTap!()));
      default:
        return Container();
    }
  }
}
