import 'package:flutter/material.dart';

class ButtonDirectional extends StatelessWidget {
  const ButtonDirectional({Key? key, this.widget, this.label})
      : super(key: key);
 // final Function()? onPressed;
  final Widget? widget;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => widget!,
        ),
      );
    }, child: Text(label!));
  }
}
