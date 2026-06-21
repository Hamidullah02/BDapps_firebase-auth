import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes.dart';

class quizScreen extends StatefulWidget {
  const quizScreen({super.key});

  @override
  State<quizScreen> createState() => _quizScreenState();
}

class _quizScreenState extends State<quizScreen> {
  int currentquesIdx = 0;
  int score = 0;
  bool isAnswered = false;
  int? selectedIdx;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Which of the following is true about a StatelessWidget?",
      "options": [
        "Its configuration and data cannot change once built",
        "It can trigger a UI rebuild automatically at any time",
      ],
      "answer": 0,
    },
    {
      "question":
          "Which tool is used to profile performance and check for memory leaks in Flutter?",
      "options": ["Flutter DevTools", "Pubspec.yaml settings"],
      "answer": 0,
    },
    {
      "question":
          "In which file do you add external packages and dependencies for a Flutter project?",
      "options": ["main.dart", "pubspec.yaml"],
      "answer": 1,
    },
    {
      "question":
          "Which widget should you use to position a single child widget exactly in the middle of its parent?",
      "options": ["Center", "Row"],
      "answer": 0,
    },
  ];

  void anscheck(int idx) {
    if (isAnswered) return;
    setState(() {
      selectedIdx = idx;
      isAnswered = true;

      if (idx == questions[currentquesIdx]['answer']) {
        score++;
      }
    });
  }

  void nextques() {
    if (currentquesIdx < questions.length - 1) {
      setState(() {
        currentquesIdx++;
        isAnswered = false;
        selectedIdx = null;
      });
    } else {
      Get.toNamed(Approutes.RESULTSCREEN, arguments: score);
    }
  }

  Color getOptionBorderColor(int index) {
    if (!isAnswered) return Colors.grey.shade300;

    final correctAnswer = questions[currentquesIdx]["answer"];
    if (index == correctAnswer) {
      return Colors.green;
    } else if (index == selectedIdx) {
      return Colors.red;
    }
    return Colors.grey.shade200;
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentquesIdx];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAllNamed(Approutes.LOGINSCREEN);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: (currentquesIdx + 1) / questions.length,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Question ${currentquesIdx + 1}/${questions.length}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Text(
              question['question'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...List.generate(question["options"].length, (index) {
              return GestureDetector(
                onTap: () => anscheck(index),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        isAnswered &&
                                index == questions[currentquesIdx]["answer"]
                            ? Colors.green.shade50
                            : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: getOptionBorderColor(index),
                      width: 2,
                    ),
                  ),
                  child: Text(
                    question["options"][index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isAnswered ? nextques : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  currentquesIdx == questions.length - 1 ? "Submit" : "Next",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
