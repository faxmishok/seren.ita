import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        height: context.height,
        width: context.width,
        color: whiteColor,
        child: Column(
          children: [
            SizedBox(height: context.height * 0.45),
            SizedBox(
              width: context.width,
              child: SlideInDown(
                child: Hero(
                  tag: 'app_logo',
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: context.width * 0.6,
                    height: context.height * 0.12,
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 1000)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
