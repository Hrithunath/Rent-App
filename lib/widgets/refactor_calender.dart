import 'package:flutter/material.dart';

Widget customtextFeildcalender(
    {required TextEditingController controller,
    required void Function()? onTapcalender,
    required String labeltext,
    required String? Function(String?)? validator,
     required AutovalidateMode autovalidateMode,
    }) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      readOnly: true,
      controller: controller,
      keyboardType: TextInputType.none,
      decoration: InputDecoration(
        labelText: labeltext,
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15)),
        suffixIcon: GestureDetector(
          onTap: onTapcalender,
          child: Icon(Icons.calendar_today))
      ),
      validator: validator,
      autovalidateMode: autovalidateMode,
    ),
  );
}
