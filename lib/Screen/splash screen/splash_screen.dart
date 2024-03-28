import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictak_app/Screen/home%20screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
//!

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animationController
        .forward()
        .then((onValue) => Get.offAll(const HomeScreen()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffFF204E),
              Color(0xffA0153E),
            ],
          ),
        ),
        child: Center(
            child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return ScaleTransition(
                    scale: _animation,
                    child: Container(
                      transform:
                          Matrix4.translationValues(0, -_animation.value, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(2, 2),
                              blurRadius: 3,
                            ),
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(-2, -2),
                              blurRadius: 3,
                            ),
                          ]),
                      child: const Image(
                        // loadingBuilder: (context, child, loadingProgress) {
                        //   return const Icon(Icons.error);
                        // },
                        image: AssetImage(
                          "assets/images/TicTac_logo.png",
                        ),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}
