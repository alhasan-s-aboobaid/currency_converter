

import 'package:flutter/material.dart';

enum INPUT_TYPE {number, text}

class EntryField extends StatefulWidget {

  final TextEditingController textEditingController;
  final INPUT_TYPE inputType;


  const EntryField({Key? key, required this.textEditingController, required this.inputType}) : super(key: key);

  @override
  State<EntryField> createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      child: TextFormField(
        validator: (value) {
          if(widget.inputType == INPUT_TYPE.text) {
          if (value != null && value.trim().length != 3) {
            return 'This field requires 3 characters';
          }
          } else {
            if (value == null) {
              return 'This field is required';
            }
          }
          return null;
        },
        controller: widget.textEditingController,
        keyboardType: widget.inputType == INPUT_TYPE.number ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
            labelText: '',
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.green),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.green),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    );
  }
}
