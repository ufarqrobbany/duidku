import 'package:flutter/material.dart';

Widget buildButtonCard(
  BuildContext context,
  String cardTitle,
  String cardSubTitle,
  action,
  children,
) {
  return MaterialButton(
    padding: const EdgeInsets.all(0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: const Color(0xffffffff),
    onPressed: action,
    elevation: 0,
    focusElevation: 0,
    hoverElevation: 0,
    highlightElevation: 0,
    disabledElevation: 1,
    child: Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    cardTitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(width: 10),
                  Text(
                    cardSubTitle,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const Icon(Icons.navigate_next),
            ],
          ),
          Container(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ),
        ],
      ),
    ),
  );
}
