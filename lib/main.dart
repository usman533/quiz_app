import 'package:flutter/material.dart';

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.green,
        ),
      ),
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  final List<Icon> _scoreKeeper = [];
  final List<Question> _questions = [
    const Question(text: 'Imran Khan is the founder of Pakistan Tehreek-e-Insaf.', answer: true),
    const Question(text: 'Imran Khan served as the President of Pakistan.', answer: false),
    const Question(text: 'Imran Khan led Pakistan to victory in the 1992 Cricket World Cup.', answer: true),
    const Question(text: 'Imran Khan was born in Karachi.', answer: false),
    const Question(text: 'Imran Khan has been the Prime Minister of Pakistan.', answer: false),
    const Question(text: 'Imran Khan is a graduate of Harvard University.', answer: false),
    const Question(text: 'Imran Khan has authored several books.', answer: true),
    const Question(text: 'Imran Khan started his political career in the 1980s.', answer: false),
    const Question(text: 'Imran Khan is married to a British socialite.', answer: true),
    const Question(text: 'Imran Khan has been the Chief Minister of Punjab.', answer: false),
    const Question(text: 'Imran Khan’s party’s main focus is on anti-corruption reforms.', answer: true),
    const Question(text: 'Imran Khan has played cricket for Pakistan .', answer: true),
  ];

  int _correctAnswers = 0;
  final int _totalQuestions = 12;

  void _checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = _questions[_currentQuestionIndex].answer;

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        _scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
        _correctAnswers++;
      } else {
        _scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      }

      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showResultDialog();
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _scoreKeeper.clear();
      _correctAnswers = 0;
    });
  }

  void _showResultDialog() {
    double percentageCorrect = (_correctAnswers / _totalQuestions) * 100;
    double percentageIncorrect = 100 - percentageCorrect;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Finished', style: TextStyle(color: Colors.black)),
        content: Text(
          'You answered $_correctAnswers out of $_totalQuestions questions correctly.\n'
              'Correct: ${percentageCorrect.toStringAsFixed(2)}%\n'
              'Incorrect: ${percentageIncorrect.toStringAsFixed(2)}%',
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetQuiz();
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.blue, // Set background color to blue
          child: const Text('Quiz App'),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.black, // Set background color to black
              child: Text(
                'Question ${_currentQuestionIndex + 1}:',
                style: const TextStyle(fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.black, // Set background color to black
              child: Text(
                _questions[_currentQuestionIndex].text,
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _checkAnswer(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    textStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('True'),
                ),
                ElevatedButton(
                  onPressed: () => _checkAnswer(false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    textStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('False'),
                ),
              ],
            ),
            Row(
              children: _scoreKeeper,
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final bool answer;

  const Question({required this.text, required this.answer});
}


