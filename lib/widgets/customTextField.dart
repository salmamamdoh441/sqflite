import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
 Function onSaved;
 String title;
 Function validator;
 int lines;
 var tab;
 TextEditingController controller;
 CustomTextField({this.validator,this.onSaved,this.title,this.lines
 ,this.controller
 ,this.tab
 });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
onSaved: widget.onSaved,
maxLines:widget.lines ,
      controller: widget.controller,
      onTap: widget.tab,
      decoration: InputDecoration(
        labelText: widget.title,

        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(20,),

        )
      ),
    );
  }
}
