import 'package:flutter/material.dart';

class MyDropdownButtonFormField extends StatefulWidget {
  MyDropdownButtonFormField(
      {Key? key,
      this.lableText,
      required this.myList,
      required this.controller})
      : super(key: key);
  final String? lableText;
  final List<String> myList;
  String controller;

  @override
  State<MyDropdownButtonFormField> createState() =>
      _MyDropdownButtonFormFieldState();
}

class _MyDropdownButtonFormFieldState extends State<MyDropdownButtonFormField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: widget.lableText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: 5,
        ),
      ),
      // value: dropdownValue,
      items: widget.myList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          child: Text(value),
          value: value,
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          widget.controller = newValue!;
          //  print(dropdownValue);
        });
      },
    );
  }
}
