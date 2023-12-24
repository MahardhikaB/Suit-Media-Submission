import 'package:flutter/material.dart';
import 'package:suitmedia_quest/components/button.dart';
import 'package:suitmedia_quest/components/text_field.dart';
import 'package:suitmedia_quest/theme/theme.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController palindromeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints.expand(),
        padding: MyTheme.screenPadding,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/ic_photo.png'),
            const SizedBox(height: 48),
            MyTextField(
              hintText: 'Name',
              controller: nameController,
              ),
            MyTextField(
              hintText: 'Palindrome',
              controller: palindromeController,
              ),
            const SizedBox(height: 24),
            MyButton(
              text: 'CHECK', 
              onPressed: () {}
              ),
            const SizedBox(height: 16),
            MyButton(
              text: 'NEXT', 
              onPressed: () {}
              ),
          ],
        ),
      ),
    );
  }
}