import 'package:number_keyboard/keyboard/number_keyboard.dart';
import 'package:number_keyboard/utils/app_color.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String numbers = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Column(
        children: [
          const Spacer(),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              numbers,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 35,
                letterSpacing: 2,
              ),
            ),
          ),
          const Spacer(),
          Text(
            '...happy coding...'.toUpperCase(),
            style: const TextStyle(letterSpacing: 4, color: Colors.white),
          ),
          const SizedBox(height: 10),
          NumberKeyboard(
            keyHeight: 55,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            keyColor: Colors.blueGrey.shade600,
            onChanged: (value) => setState(() => numbers = value),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
