import 'dart:math';

import 'package:flutter/material.dart';

import '../ui/colors.dart' as color;

import '../widgets/figure.dart';
import '../widgets/letter.dart';
import '../helpers/game.dart';
import '../helpers/word_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Game game = Game();
  WordList wordList = WordList();
  String word = '';

  @override
  void initState() {
    super.initState();
    getRandWord();
  }

  void getRandWord() {
    final random = Random();
    int i = random.nextInt(wordList.words.length);
    word = wordList.words[i].toUpperCase();
  }

  gameEnded() {
    List<String> charList = word.split('');

    return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content:
                charList.every((element) => game.selectedChar.contains(element))
                    ? const Text('You Won')
                    : Text('You\'ve lost this round, the answer was $word'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      getRandWord();
                      game.gameTries = 0;
                      game.selectedChar.clear();
                    });
                  },
                  child: const Text('Restart Game'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List<String> charList = word.split('');
    return Scaffold(
      backgroundColor: color.AppColor.primaryColor,
      appBar: AppBar(
        title: const Text('Hangman'),
        centerTitle: true,
        backgroundColor: color.AppColor.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(children: [
                figure(game.gameTries >= 0, 'assets/images/hang.png'),
                figure(game.gameTries >= 1, 'assets/images/head.png'),
                figure(game.gameTries >= 2, 'assets/images/body.png'),
                figure(game.gameTries >= 3, 'assets/images/ra.png'),
                figure(game.gameTries >= 4, 'assets/images/la.png'),
                figure(game.gameTries >= 5, 'assets/images/rl.png'),
                figure(game.gameTries >= 6, 'assets/images/ll.png'),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: word
                    .split('')
                    .map((e) => letter(e.toUpperCase(),
                        game.selectedChar.contains(e.toUpperCase())))
                    .toList(),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 250,
                child: GridView.count(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: game.alphabets.map((e) {
                    return RawMaterialButton(
                      onPressed: game.selectedChar.contains(e)
                          ? null
                          : () {
                              setState(() {
                                game.selectedChar.add(e);

                                if (!word.split('').contains(e)) {
                                  game.gameTries++;
                                }
                              });
                              if (game.gameTries == 6 ||
                                  charList.every((element) =>
                                      game.selectedChar.contains(element))) {
                                gameEnded();
                              }
                            },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      fillColor: game.selectedChar.contains(e)
                          ? Colors.black87
                          : Colors.blue,
                      child: Text(
                        e,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      getRandWord();
                      game.gameTries = 0;
                      game.selectedChar.clear();
                    });
                  },
                  child: const Text('Restart Game'))
            ],
          ),
        ),
      ),
    );
  }
}
