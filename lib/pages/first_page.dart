import 'package:flutter/material.dart';
import 'package:suitmedia_quest/components/button.dart';
import 'package:suitmedia_quest/components/text_field.dart';
import 'package:suitmedia_quest/pages/second_page.dart';
import 'package:suitmedia_quest/theme/theme.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  static const routeName = '/first-page';

  void _checkPalindrome(BuildContext context, String text) {
    final originalText = text.toLowerCase().replaceAll(' ', '');
    final reversedText = originalText.split('').reversed.join('');

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please input text'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    if (originalText == reversedText) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Palindrome'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not Palindrome'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _configNextButton(BuildContext context, String name) {
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please input text'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondPage(name: name),
      )
    );
  }

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String name = '';
  String palindrome = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                initialValue: name,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                ),
              MyTextField(
                hintText: 'Palindrome',
                initialValue: palindrome,
                onChanged: (value) {
                  setState(() {
                    palindrome = value;
                  });
                },
                ),
              const SizedBox(height: 24),
              MyButton(
                text: 'CHECK', 
                onPressed: () {
                  widget._checkPalindrome(context, palindrome);
                }
                ),
              const SizedBox(height: 16),
              MyButton(
                text: 'NEXT', 
                onPressed: () {
                  widget._configNextButton(context, name);
                }
                ),
            ],
          ),
        ),
      ),
    );
  }
}