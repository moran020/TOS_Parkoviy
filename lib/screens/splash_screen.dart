import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

// Заставка
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed('/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splashscreen.jpg',
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'ТОС «Парковый»',
            style: TextStyle(
                fontSize: 35,
                color: Colors.green,
                fontStyle: FontStyle.italic,
                fontFamily: 'Aerovista'),
            textAlign: TextAlign.end,
          ),
          const SizedBox(
            height: 15,
          ),
          RichText(
              text: const TextSpan(children: [
            TextSpan(
                text: 'Вместе сможем больше',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Aerovista')),
            TextSpan(
                text: '!',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Aerovista'))
          ])),
        ],
      ),
    );
  }
}
