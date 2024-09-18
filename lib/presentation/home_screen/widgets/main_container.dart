// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  MainContainer({
    super.key,
    required this.child,
  });
  Widget child;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .4,
      width: size.width * .8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 10),
            blurRadius: 20,
            spreadRadius: 4,
          ),
        ],
      ),
      child: child,
    );
  }
}
