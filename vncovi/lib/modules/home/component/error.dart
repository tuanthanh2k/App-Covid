import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  const Error({Key? key, this.message}) : super(key: key);

  final String? message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(message ?? 'Rấc tiếc, đã xảy ra lỗi!',
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}