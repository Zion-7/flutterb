import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constant.dart';

class Resultbox extends StatelessWidget {
  const Resultbox({
    super.key,
    required this.result,
    required this.questionLength,
    required this.onpressed,
  });

  final int result;
  final int questionLength;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Score',
              style: TextStyle(
                  color: Color.fromARGB(255, 60, 244, 54), fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: onpressed,
              child: const Text(
                'start over',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            CircleAvatar(
              child: Text('$result/$questionLength'),
            ),
          ],
        ),
      ),
    );
  }
}
