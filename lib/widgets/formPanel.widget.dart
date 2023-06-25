import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MvoyFormPanel extends StatelessWidget {
  final Widget child;
  const MvoyFormPanel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.only(
            top: baseSize.height * .05, left: baseSize.width * .05, bottom: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 5,
            blurRadius: 0,
            offset: Offset(5, 10), // changes position of shadow
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: child,
      ),
    );
  }
}
