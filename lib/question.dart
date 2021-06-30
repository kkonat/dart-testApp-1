import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);
  //const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(questionText);
  }
}
