import 'package:flutter/material.dart';

Widget buildCashFlow(
    String buttonText, IconData buttonIcon, Color buttonColor) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(
        color: Color(0xffeeeeee),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          child: Icon(
            buttonIcon,
            color: Colors.white,
            size: 15,
          ),
        ),
        Text(
          buttonText,
          style: const TextStyle(color: Color(0xff121212)),
        ),
      ]),
    ),
  );
}
