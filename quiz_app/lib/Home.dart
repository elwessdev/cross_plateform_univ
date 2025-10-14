import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _QuizState();
}

class _QuizState extends State<HomePage> {
  final Map qts = {
    0: {
      "question": "What is Fasts Programming Language?",
      "answers": [
        {"text": "Python", "score": 1},
        {"text": "C++", "score": 3},
        {"text": "C", "score": 4},
      ],
    },
    1: {
      "question": "Best Programming Language for Mobile Apps?",
      "answers": [
        {"text": "Java", "score": 1},
        {"text": "Dart", "score": 4},
        {"text": "Kotlin", "score": 3},
      ],
    },
    2: {
      "question": "Best Programming Language for Web Apps?",
      "answers": [
        {"text": "JavaScript", "score": 4},
        {"text": "PHP", "score": 2},
        {"text": "Python", "score": 3},
      ],
    },
    3: {
      "question": "Best Programming Language for AI?",
      "answers": [
        {"text": "Python", "score": 4},
        {"text": "Java", "score": 2},
        {"text": "C++", "score": 3},
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "${currentQuestionIndex + 1}/${qts.length}",
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
          SizedBox(height: 25),
          ...(qts[currentQuestionIndex]["answers"] as List)
              .map((answer) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple
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
                                'Wilyeeeee',
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Score is: $totalScore',
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
              }).toList(),
        ],
      ),
    );
  }
}
