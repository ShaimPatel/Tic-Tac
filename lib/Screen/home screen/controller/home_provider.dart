import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<String> gameValue = ["", "", "", "", "", "", "", "", ""].obs;

  RxList patterValue = [].obs;

  RxBool isWinner = false.obs;
  RxBool isX = false.obs;
  RxInt click = 0.obs;
  RxBool isMatchdraw = false.obs;

  RxInt player0Wins = 0.obs;
  RxInt playerXWins = 0.obs;

  RxBool showMessage = false.obs;

  void addValue(int index) {
    if (gameValue[index] == "") {
      if (isX.value) {
        gameValue[index] = "X";
        isX.value = !isX.value;
        click++;
      } else {
        gameValue[index] = "O";
        isX.value = !isX.value;
        click++;
      }
    } else {
      if (kDebugMode) {
        print("Invalid click");
      }
    }
    checkWinnerPlayer();
  }

  //! Draw Match Message

  void matchDrawMessage(click) {
    if (click == 9) {}
  }

  void checkWinnerPlayer() {
//!1
// 1) [(0 ==1 ) , (0 == 2) ,(0 != '')]
//2) [(0 == 4) , (0 == 8) , (0 != '')]
//3) [(0 ==3) ,(0 ==6) , (0 !='')]
//! 2
//1) [(1 == 4) && (1 == 7) && (1 != "")]
//! 3
//1) [(2 == 4) && (2 == 6) & (2 !="")]
//2) [(2==5) && (2 == 8) && (2 != "")]
//! 4
//1) [(3 == 4) && (3 == 5) && (3 != "")]
//!5
//1) [(6 == 7 ) && (6 == 7) && (6!="")]

    if (gameValue[0] == gameValue[1] &&
        gameValue[0] == gameValue[2] &&
        gameValue[0] != "") {
      showMessage.value = true;
      isMatchdraw.value = false;
      patterValue.addAll([0, 1, 2]);
      isX.value == true ? player0Wins++ : playerXWins++;
    } else if (gameValue[0] == gameValue[4] &&
        gameValue[0] == gameValue[8] &&
        gameValue[0] != "") {
      showMessage.value = true;
      isMatchdraw.value = false;
      isX.value == true ? player0Wins++ : playerXWins++;
      patterValue.addAll([0, 4, 8]);
    } else if (gameValue[0] == gameValue[3] &&
        gameValue[0] == gameValue[6] &&
        gameValue[0] != "") {
      showMessage.value = true;
      isMatchdraw.value = false;
      isX.value == true ? player0Wins++ : playerXWins++;
      patterValue.addAll([0, 3, 6]);
    } else if (gameValue[1] == gameValue[4] &&
        gameValue[1] == gameValue[7] &&
        gameValue[1] != "") {
      showMessage.value = true;
      isMatchdraw.value = false;
      isX.value == true ? player0Wins++ : playerXWins++;
      patterValue.addAll([1, 4, 7]);
    } else if (gameValue[2] == gameValue[4] &&
        gameValue[2] == gameValue[6] &&
        gameValue[2] != "") {
      showMessage.value = true;
      isMatchdraw.value = false;
      isX.value == true ? player0Wins++ : playerXWins++;
      patterValue.addAll([2, 4, 6]);
    } else if (gameValue[2] == gameValue[5] &&
        gameValue[2] == gameValue[8] &&
        gameValue[2] != "") {
      showMessage.value = true;
      isMatchdraw.value = false;
      isX.value == true ? player0Wins++ : playerXWins++;
      patterValue.addAll([2, 5, 8]);
    } else if (gameValue[3] == gameValue[4] &&
        gameValue[3] == gameValue[5] &&
        gameValue[3] != "") {
      showMessage.value = true;
      isMatchdraw.value = false;
      isX.value == true ? player0Wins++ : playerXWins++;
      patterValue.addAll([3, 4, 5]);
    } else if (gameValue[6] == gameValue[7] &&
        gameValue[6] == gameValue[8] &&
        gameValue[6] != "") {
      showMessage.value = true;
      isMatchdraw.value = false;
      isX.value == true ? player0Wins++ : playerXWins++;
      patterValue.addAll([6, 7, 8]);
    } else {
      if (isWinner.value == false) {
        if (click.value == 9) {
          isMatchdraw.value = true;
          showMessage.value = true;
        }
      }
    }
  }

//! winner dialog box

  void winnerDialogBox() {
    isX.value == true ? player0Wins++ : playerXWins++;
    Get.defaultDialog(
        title: "🥇 Winner 🥇",
        content: Column(
          children: [
            const Icon(
              Icons.confirmation_num_rounded,
              size: 50,
              color: Colors.green,
            ),
            const SizedBox(height: 10),
            isX.value != true
                ? const Text(
                    "X Is Winner",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )
                : const Text(
                    "O Is Winner",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    gameValue.value = ["", "", "", "", "", "", "", "", ""];
                    click.value = 0;
                    isWinner.value = false;
                    isX.value = false;
                    player0Wins.value = 0;
                    playerXWins.value = 0;
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text("Close"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    gameValue.value = ["", "", "", "", "", "", "", "", ""];
                    click.value = 0;
                    isWinner.value = false;
                    isX.value = false;
                    Get.back();
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Play Again"),
                ),
              ],
            )
          ],
        ));
  }

  @override
  void onInit() {
    // print(showMessage.value);
    super.onInit();
  }
}
