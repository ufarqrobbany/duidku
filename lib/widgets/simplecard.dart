import 'package:flutter/material.dart';

Widget buildSimpleCard(
  BuildContext context,
  double marginTop,
  double marginBottom,
  String cardTitle,
  String cardSubTitle,
  action,
  children,
) {
  return Container(
    margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
    padding: const EdgeInsets.all(10.0),
    width: MediaQuery.of(context).size.width * .9,
    decoration: const BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            InkWell(
              onTap: action,
              child: const Icon(Icons.navigate_next),
            )
          ],
        ),
        Container(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ],
    ),
  );
}
