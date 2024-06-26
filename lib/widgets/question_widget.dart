import 'package:flutter/material.dart';
import 'package:start_quiz/constant.dart';

class Questionwidget extends StatelessWidget {
  const Questionwidget(
      {super.key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions});
  final String question;
  final int indexAction;
  final int totalQuestions;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Question ${indexAction + 1}/$totalQuestions: $question',
        style: TextStyle(
          fontSize: 24.0,
          color: neutral,
        ),
      ),
    );
  }
}

























/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Questionwidget extends StatelessWidget {
  const Questionwidget(
      {super.key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions});
  final String question;
  final int indexAction;
  final int totalQuestions;
  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      alignment: Alignment.centerLeft,
      child: Text('Question ${indexAction + 1}/$totalQuestions: $question'),
    );
  }
}*/
