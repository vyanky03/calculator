// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstnum = 0.0;
  double secondnum = 0.0;
  var userinput = '';
  var answer = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 28.0;

  onbuttonClick(value) {
    if (value == 'AC') {
      userinput = '';
      answer = '';
    } else if (value == 'CL') {
      if (userinput.isNotEmpty) {
        userinput = userinput.substring(0, userinput.length - 1);
      }
    } else if (value == '=') {
      if (userinput.isNotEmpty) {
        var finalinput = userinput;
        Parser p = Parser();
        Expression expression = p.parse(finalinput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        answer = finalValue.toString();
        if (answer.endsWith('.0')) {
          answer = answer.substring(0, answer.length - 2);
        }
        userinput = answer;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      userinput = userinput + value;
      hideInput = false;
      outputSize = 28.0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(115, 0, 0, 0),
      body: Column(
        children: [
          // i/o area
          Expanded(
              child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            color: Color.fromARGB(164, 95, 80, 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideInput ? '' : userinput,
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  answer,
                  style: TextStyle(
                    fontSize: outputSize,
                    color: Color.fromARGB(161, 255, 255, 255),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )),

          // button area
          Row(
            children: [
              button(text: 'AC'),
              button(
                text: '( )',
              ),
              button(text: '%'),
              button(text: '/'),
            ],
          ),
          Row(
            children: [
              button(text: '7'),
              button(text: '8'),
              button(text: '9'),
              button(text: '*'),
            ],
          ),
          Row(
            children: [
              button(text: '4'),
              button(text: '5'),
              button(text: '6'),
              button(text: '-'),
            ],
          ),
          Row(
            children: [
              button(text: '1'),
              button(text: '2'),
              button(text: '3'),
              button(text: '+'),
            ],
          ),
          Row(
            children: [
              button(text: '0'),
              button(text: '.'),
              button(text: 'CL'),
              button(text: '='),
            ],
          )
        ],
      ),
    );
  }

  Widget button({
    text,
    tcolor = Colors.white,
  }) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: const [
          Color.fromARGB(23, 67, 67, 67),
          Color.fromARGB(255, 67, 67, 67),
        ]),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
            shadowColor: Colors.transparent,
            padding: EdgeInsets.all(19),
          ),
          onPressed: () => onbuttonClick(text),
          child: Text(text,
              style: TextStyle(
                fontSize: 26,
                color: tcolor,
                fontWeight: FontWeight.bold,
                fontFamily: 'OneSans',
              ))),
    ));
  }
}
