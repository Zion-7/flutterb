import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/quiz': (context) => QuizScreen(),
        '/quizBody': (context) => QuizBodyPage(),
      },
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.purple[900],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/image/quiz.jpg'), // Your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Check login credentials
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  if (username == 'admin' && password == 'password') {
                    Navigator.pushReplacementNamed(context, '/quiz');
                  } else {
                    // Show error message
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Invalid username or password.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/quizBody');
                },
                child: Text('View Quiz Body'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  bool _quizCompleted = false;
  List<String> _feedback = [];
  bool _questionAnswered = false;
  List<Map<String, dynamic>> _questions = [
    {
      'questionText': 'By combining widgets in a visual editor',
      'answers': ['True', 'False'],
      'correctAnswer': false,
    },
    {
      'questionText':
          'What is the main building block of a Flutter application?',
      'answers': ['Widgets', 'Functions', 'Classes', 'Variables'],
      'correctAnswer': 'Widgets',
    },
    {
      'questionText':
          'What is the recommended programming language for building Flutter apps?',
      'answers': ['Dart', 'Java', 'Python', 'JavaScript'],
      'correctAnswer': 'Dart',
    },
  ];

  void _answerQuestion(String selectedAnswer) {
    setState(() {
      if (_quizCompleted || _questionAnswered) {
        return;
      }
      if (selectedAnswer ==
          _questions[_currentQuestionIndex]['correctAnswer']) {
        _feedback.add('Correct!');
      } else {
        _feedback.add(
            'Incorrect! Correct answer: ${_questions[_currentQuestionIndex]['correctAnswer']}');
      }
      _questionAnswered = true;
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _feedback.clear();
        _questionAnswered = false;
      } else {
        _quizCompleted = true;
      }
    });
  }

  void _submitQuiz() {
    setState(() {
      _quizCompleted = true;
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _quizCompleted = false;
      _feedback.clear();
      _questionAnswered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: _quizCompleted ? _buildQuizResult() : _buildQuestion(),
    );
  }

  Widget _buildQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            _questions[_currentQuestionIndex]['questionText'],
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        SizedBox(height: 10.0),
        ...(_questions[_currentQuestionIndex]['answers'] as List<String>).map(
          (answer) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed:
                    _questionAnswered ? null : () => _answerQuestion(answer),
                child: Text(answer),
              ),
            );
          },
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: _questionAnswered ? _nextQuestion : null,
          child: Text(_currentQuestionIndex < _questions.length - 1
              ? 'Next Question'
              : 'Submit Quiz'),
        ),
      ],
    );
  }

  Widget _buildQuizResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Quiz Completed!',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.0),
        Text(
          'Your Score: ${_feedback.where((fb) => fb == 'Correct!').length} / ${_questions.length}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 20.0),
        TextButton(
          onPressed: _restartQuiz,
          child: Text('Restart Quiz'),
        ),
      ],
    );
  }
}

class QuizBodyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Body'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is the Quiz Body page',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/quiz');
              },
              child: Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
