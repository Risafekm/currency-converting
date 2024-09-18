import 'package:currency_main/core/const.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.size,
    required this.text,
    required this.isIcon,
    required this.onTap,
  });

  final Size size;
  final String text;
  final bool isIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: size.width,
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                text,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                    fontSize: 15),
              ),
            ),
            const SizedBox(width: 8),
            isIcon
                ? const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 16,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
