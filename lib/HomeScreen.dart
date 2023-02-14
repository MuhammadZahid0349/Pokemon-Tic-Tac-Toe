import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tic_tac_toc/Widgets/tictactoe.dart';
import 'package:tic_tac_toc/highScore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(height: 25, child: Image.asset("assets/r.gif")),
            Text(
              "Pokemon",
              style: TextStyle(color: Colors.black),
            ),
            Container(height: 25, child: Image.asset("assets/r.gif")),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          TicTacToe(),
          OutlinedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HighScore()));
              },
              child: Text("View High Score")),
        ],
      ),
    );
  }
}
