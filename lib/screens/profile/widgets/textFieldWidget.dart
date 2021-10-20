import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final TextAlign textAlign;
  final String text;
  final String hintText;
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback onTap;
  final ValueChanged<String> onChanged;

  const TextFieldWidget(
      {Key key,
      this.maxLines = 1,
      this.hintText,
      this.label,
      this.text,
      this.onChanged,
      this.readOnly,
      this.onTap,
      this.textAlign,
      this.controller})
      : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.text ?? "";
  }

  @override
  void dispose() {
    controller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          textAlign: widget.textAlign ?? TextAlign.left,
          onTap: widget.onTap,
          readOnly: widget.readOnly ?? false,
          onChanged: widget.onChanged,
          maxLines: widget.maxLines,
          controller: widget.text != null ? controller : widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
