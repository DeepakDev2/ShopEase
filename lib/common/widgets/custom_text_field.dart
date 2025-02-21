import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.hint,
    this.maxLine = 1,
  });
  final TextEditingController textEditingController;
  final String hint;
  final int maxLine;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      maxLines: maxLine,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter your $hint";
        }
        return null;
      },
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariables.secondaryColor,
            width: 2,
          ),
        ),
        // border: const OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: Colors.black,
        //     width: 8,
        //   ),
        // ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
            // width: 3,
          ),
        ),
      ),
    );
  }
}
