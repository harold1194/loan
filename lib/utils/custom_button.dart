import 'package:flutter/material.dart';

import 'my_colors.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final Color color;
  final String titleButton;
  const CustomButton({
    super.key,
    this.onPressed,
    required this.color,
    required this.titleButton,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shadowColor: AppColors().kboxShadow,
          elevation: 0.1,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          backgroundColor: color,
          fixedSize: const Size(175, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(
        titleButton,
        style: TextStyle(color: AppColors().kWhiteText),
      ),
    );
  }
}
