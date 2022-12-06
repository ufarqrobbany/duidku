import 'package:flutter/material.dart';

AppBar buildAppBar(
  context,
  bool isHome,
  String title,
  bool hasAction,
  IconData actionIcon,
  actionRoute,
) {
  return AppBar(
    title: Container(
      padding: EdgeInsets.only(top: isHome ? 7.5 : 0),
      child: Text(
        title,
        style: isHome
            ? const TextStyle(
                fontFamily: 'Aqua',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )
            : const TextStyle(
                color: Colors.black,
              ),
      ),
    ),
    actions: [
      hasAction
          ? Container(
              padding: const EdgeInsets.only(right: 7.5),
              child: IconButton(
                icon: Icon(
                  actionIcon,
                  color: isHome ? Colors.white : Colors.black,
                  size: 20,
                ),
                splashRadius: 25,
                onPressed: actionRoute,
              ),
            )
          : Container(),
    ],
    backgroundColor: isHome ? const Color(0xff121212) : Colors.white,
    elevation: 0.0,
    automaticallyImplyLeading: false,
  );
}
