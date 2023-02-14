import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<bool?> board = [];
  bool trun = true;
  bool show = false;

  @override
  void initState() {
    for (int i = 0; i < 9; i++) {
      board.add(null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(border: TableBorder.all(width: 3), children: [
          TableRow(children: [
            TableCell(child: slot(0)),
            TableCell(child: slot(1)),
            TableCell(child: slot(2)),
          ]),
          TableRow(children: [
            TableCell(child: slot(3)),
            TableCell(child: slot(4)),
            TableCell(child: slot(5)),
          ]),
          TableRow(children: [
            TableCell(child: slot(6)),
            TableCell(child: slot(7)),
            TableCell(child: slot(8)),
          ]),
        ]),
        show ? Container(child: Image.asset("assets/p.gif")) : Container(),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  bool hasWonGame(bool b) {
    const List<List<int>> winningCombos = [
      // horizontal
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      // vertical
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      // diagonal
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (int i = 0; i < winningCombos.length; i++) {
      List<int> check = winningCombos[i];
      if (board[check[0]] == b &&
          board[check[1]] == b &&
          board[check[2]] == b) {
        return true;
      }
    }
    return false;
  }

  tie() {
    for (int i = 0; i < 9; i++) {
      if (board[i] == null) {
        return false;
      }
    }
    return true;
  }

  evaluateGame(context) async {
    if (hasWonGame(trun)) {
      return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Container(height: 25, child: Image.asset("assets/ff.png")),
              SizedBox(
                width: 15,
              ),
              Text("Congratulations!"),
            ],
          ),
          content:
              Text((trun ? "Pikachu" : "Bulbasaur") + " has won the game!"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  for (int i = 0; i < 9; i++) {
                    board[i] = null;
                  }
                  show = true;
                });
                Navigator.of(context).pop();
              },
              child: Text("PLAY AGAIN"),
            ),
          ],
        ),
      );
    }
    if (tie()) {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Container(height: 25, child: Image.asset("assets/ff.png")),
              SizedBox(
                width: 15,
              ),
              Text("Congratulations!"),
            ],
          ),
          content: Text("You loss the match!!! :(("),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  for (int i = 0; i < 9; i++) {
                    board[i] = null;
                  }
                  show = false;
                });
                Navigator.of(context).pop();
              },
              child: Text("PLAY AGAIN"),
            ),
          ],
        ),
      );
    }
    trun = !trun;
  }

  Widget slot(int i) {
    return InkWell(
        onTap: () {
          if (board[i] != null) {
            return;
          }
          setState(() {
            board[i] = trun;
          });
          return evaluateGame(context);
        },
        child: board[i] == null
            ? SizedBox(
                height: 130,
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Image.asset(
                    board[i] == true ? 'assets/T.png' : 'assets/F.png',
                    height: 100,
                  ),
                ),
              )
        // Container(
        //   height: 120,
        // ),
        );
  }
}
