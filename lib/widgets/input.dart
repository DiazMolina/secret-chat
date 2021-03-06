import 'package:flutter/material.dart';
class InputText extends StatefulWidget {
  final String label;
  final Function(String) validator;
final bool isSecure;
final TextInputType inputType;
final double fontSize;
  const InputText({Key key, this.label, this.validator, this.isSecure=false, this.inputType=TextInputType.text, this.fontSize=16}) : super(key: key);
  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType,
      obscureText:widget.isSecure ,
      validator: widget.validator,
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: widget.fontSize),
        alignLabelWithHint: true,
        labelText: widget.label,
        contentPadding: EdgeInsets.symmetric(vertical: 10)
      ),
    );
  }
}
