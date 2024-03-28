import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:tictak_app/Screen/home%20screen/controller/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final homeController = Get.put(HomeController());
  late AnimationController _animationController;
  late Animation<double> _animation;
  late AnimationController _dashBoardController;
  late Animation<double> _dashanimation;
  late AnimationController _textController;
  late Animation<double> _textanimation;

  @override
  void initState() {
    startFadeAnimation();
    // _animationController = AnimationController(
    //   duration: const Duration(seconds: 2),
    //   vsync: this,
    // );

    // _animation = Tween<double>(begin: 0, end: 1).animate(
    //   CurvedAnimation(
    //     parent: _animationController,
    //     curve: Curves.easeIn,
    //   ),
    // );

    // _dashBoardController = AnimationController(
    //   duration: const Duration(seconds: 2),
    //   vsync: this,
    // );

    // _dashanimation = Tween<double>(begin: 0, end: 1).animate(
    //   CurvedAnimation(
    //     parent: _dashBoardController,
    //     curve: Curves.easeIn,
    //   ),
    // );

    // //! Text
    // _textController = AnimationController(
    //   duration: const Duration(seconds: 2),
    //   vsync: this,
    // );

    // _textanimation = Tween<double>(begin: 0, end: 1).animate(
    //   CurvedAnimation(
    //     parent: _textController,
    //     curve: Curves.easeIn,
    //   ),
    // );

    // _animationController.forward().whenComplete(() {
    //   _dashBoardController.forward().whenComplete(() {
    //     _textController.forward();
    //   });
    // });

    super.initState();
  }

  void startFadeAnimation() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _dashBoardController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _dashanimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _dashBoardController,
        curve: Curves.easeIn,
      ),
    );

    //! Text
    _textController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _textanimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward().whenComplete(() {
      _dashBoardController.forward().whenComplete(() {
        _textController.forward();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F6BB),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F6BB),
        title: const Text(
          "Tic Tac",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(
              onTap: () {
                startFadeAnimation();
                // Reset game logic
                homeController.patterValue.value = [];
                homeController.gameValue.value = List.filled(9, "");
                homeController.click.value = 0;
                homeController.showMessage.value = false;
                homeController.player0Wins.value = 0;
                homeController.playerXWins.value = 0;

                Get.snackbar(
                  "Tic Tac",
                  "Game restarted successfully",
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  isDismissible: true,
                  dismissDirection: DismissDirection.down,
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: const CircleAvatar(
                backgroundColor: Color(0xff114232),
                child: Icon(
                  Icons.restart_alt,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          dashBoard(context),
        ],
      ),
    );
  }

  Widget dashBoard(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Player indicator widget
            FadeTransition(
              opacity: _animation,
              child: Obx(
                () => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: homeController.isX.value == false
                        ? const Color(0xff0D9276)
                        : const Color(0xff114232),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        homeController.isX.value == false
                            ? "Player 0"
                            : "Player X",
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Game board
        FadeTransition(
          opacity: _dashanimation,
          child: SizedBox(
            height: Get.height * 0.48,
            width: Get.width,
            child: GridView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    homeController.addValue(index);
                  },
                  child: Obx(
                    () => Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: homeController.patterValue.contains(index)
                            ? const Color(0xff87A922)
                            : const Color(0xffFCDC2A),
                      ),
                      child: Center(
                        child: Text(
                          homeController.gameValue[index],
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Win count display
        FadeTransition(
          opacity: _textanimation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    "Player 0",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Obx(
                    () => Text(
                      homeController.player0Wins.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "Player X",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Obx(
                    () => Text(
                      homeController.playerXWins.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),

        // Win message and play again button
        Obx(() {
          if (kDebugMode) {
            print("Play again${homeController.showMessage.value}");
          }
          return homeController.showMessage.value == true
              ? Column(
                  children: [
                    homeController.isMatchdraw.value == false
                        ? Text(
                            homeController.isX.value != true
                                ? "X Is Winner"
                                : "0 Is Winner",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Text(
                            "Draw the match",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    const SizedBox(height: 25),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff114232),
                        foregroundColor: Colors.white,
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Play Again"),
                      onPressed: () {
                        if (kDebugMode) {
                          print(homeController.showMessage.value);
                        }
                        homeController.patterValue.value = [];
                        homeController.gameValue.value = List.filled(9, "");
                        homeController.click.value = 0;
                        homeController.isWinner.value = false;
                        homeController.showMessage.value = false;
                      },
                    ),
                  ],
                )
              : const SizedBox();
        }),
      ],
    );
  }
}
