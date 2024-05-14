import 'package:flutter/material.dart';
import '../constant.dart';
import '../models/question_model.dart';
import '../widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';
import '../widgets/tesult_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Question> questions = [
    Question(
        id: '10',
        title: 'What are the main building blocks of Flutter UIs?',
        options: {
          'Function': false,
          'Component': false,
          'Blocks': false,
          'Widgets': true
        }),
    Question(id: '11', title: 'How are Flutter UIs Built?', options: {
      'By combining widgets in a visual editor': false,
      'By using XCode for iOS and Android Studio for Android': false,
      'By combining widgets in code': false,
      'By defining widgets in config files': true
    }),
  ];
  int index = 0;
  int score = 0;
  bool isPressed = false;

  void nextQuestion() {
    if (index == questions.length - 1) {
      showDialog(
          context: context,
          builder: (ctx) => Resultbox(
                result: score,
                questionLength: questions.length,
                onpressed: () {},
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select any option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  void C() {
    setState(() {
      isPressed = true;

      score++;
    });
  }

  void startover() {
    index = 0;
    score = 0;
    isPressed = false;
    var isAreadySelected = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Start Quiz'),
        backgroundColor: background,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Questionwidget(
              indexAction: index,
              totalQuestions: questions.length,
              question: questions[index].title,
            ),
            const SizedBox(height: 25.0),
            Column(
              children: questions[index].options.entries.map((entry) {
                final option = entry.key;
                final isCorrect = entry.value;

                return OptionCard(
                  option: option,
                  color:
                      isPressed ? (isCorrect ? correct : incorrect) : neutral,
                  onTap: C,
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
