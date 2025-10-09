import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wessQuizy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('wessQuizy')),
        body: QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final Map qts = {
    0: {
      "question": "What is the capital of France?",
      "answers": [
        {"text": "Berlin", "score": 0},
        {"text": "Madrid", "score": 0},
        {"text": "Paris", "score": 3},
      ],
    },
    1: {
      "question": "What is 2 + 2?",
      "answers": [
        {"text": "3", "score": 0},
        {"text": "4", "score": 3},
        {"text": "5", "score": 0},
      ],
    },
    2: {
      "question": "What is the capital of Japan?",
      "answers": [
        {"text": "Seoul", "score": 0},
        {"text": "Tokyo", "score": 3},
        {"text": "Beijing", "score": 0},
      ],
    },
    3: {
      "question": "Which planet is known as the Red Planet?",
      "answers": [
        {"text": "Venus", "score": 0},
        {"text": "Mars", "score": 3},
        {"text": "Jupiter", "score": 0},
      ],
    },
  };

  int currentQuestionIndex = 0;
  int totalScore = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.deepPurple.shade50,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Question ${currentQuestionIndex + 1}/${qts.length}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    qts[currentQuestionIndex]["question"] as String,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          ...(qts[currentQuestionIndex]["answers"] as List<Map<String, Object>>)
              .map((answer) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.deepPurple.shade200),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () {
                      setState(() {
                        totalScore += answer["score"] as int;

                        if (currentQuestionIndex < qts.length - 1) {
                          currentQuestionIndex++;
                        } else {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(
                                'Quiz Completed!',
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.emoji_events,
                                    size: 50,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'Your total score: $totalScore',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      currentQuestionIndex = 0;
                                      totalScore = 0;
                                    });
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text(
                                    'Restart Quiz',
                                    style: TextStyle(color: Colors.deepPurple),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      });
                    },
                    child: Text(
                      answer["text"] as String,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              })
              .toList(),
          SizedBox(height: 20),
          LinearProgressIndicator(
            value: (currentQuestionIndex + 1) / qts.length,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
          ),
        ],
      ),
    );
  }
}
