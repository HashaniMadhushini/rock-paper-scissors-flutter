import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RockPaperScissors(),
    );
  }
}

class RockPaperScissors extends StatefulWidget {
  const RockPaperScissors({super.key});

  @override
  State<RockPaperScissors> createState() => _RockPaperScissorsState();
}

class _RockPaperScissorsState extends State<RockPaperScissors> {

  final List<Map<String, String>> choices = [
    {"name": "Rock", "emoji": "✊"},
    {"name": "Paper", "emoji": "✋"},
    {"name": "Scissors", "emoji": "✌️"},
  ];

  String userChoice = "";
  String computerChoice = "";
  String result = "Make your move!";

  int userScore = 0;
  int computerScore = 0;

  void playGame(Map<String, String> choice) {
    final random = Random();
    final compChoice = choices[random.nextInt(choices.length)];

    setState(() {
      userChoice = choice["name"]!;
      computerChoice = compChoice["name"]!;

      if (userChoice == computerChoice) {
        result = "It's a Draw!";
      } 
      else if ((userChoice == "Rock" && computerChoice == "Scissors") ||
          (userChoice == "Paper" && computerChoice == "Rock") ||
          (userChoice == "Scissors" && computerChoice == "Paper")) {
        result = "You Win!";
        userScore++;
      } 
      else {
        result = "Computer Wins!";
        computerScore++;
      }
    });
  }

  void resetGame() {
    setState(() {
      userScore = 0;
      computerScore = 0;
      userChoice = "";
      computerChoice = "";
      result = "Game Reset! Make your move!";
    });
  }

  Color getResultColor() {
    if (result.contains("Win")) {
      return Colors.green;
    } else if (result.contains("Computer")) {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

  Widget buildChoiceButton(Map<String, String> choice) {
    return GestureDetector(
      onTap: () => playGame(choice),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.shade100,
          border: Border.all(
            color: userChoice == choice["name"]
                ? Colors.green
                : Colors.transparent,
            width: 4,
          ),
        ),
        child: Text(
          choice["emoji"]!,
          style: const TextStyle(fontSize: 40),
        ),
      ),
    );
  }

  Widget displayChoice(String title, String choice) {
    String emoji = "";
    for (var item in choices) {
      if (item["name"] == choice) {
        emoji = item["emoji"]!;
      }
    }

    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
            border: Border.all(
              color: const Color.fromARGB(255, 4, 49, 86),
              width: 3,
            ),
          ),
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 45),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text("Rock Paper Scissors"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                displayChoice("You", userChoice),
                displayChoice("Computer", computerChoice),
              ],
            ),

            const SizedBox(height: 30),

            Text(
              result,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: getResultColor(),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Score: You $userScore  -  $computerScore Computer",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: choices
                  .map((choice) => buildChoiceButton(choice))
                  .toList(),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: resetGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 12),
              ),
              child: const Text(
                "Reset Game",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}