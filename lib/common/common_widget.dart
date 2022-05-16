import 'package:flutter/material.dart';

class BioMatricButton extends StatelessWidget {
  final Function() onClick;
  final String buttonTitle;
  const BioMatricButton(
      {required this.onClick, required this.buttonTitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      child: Text(
        buttonTitle,
        style: const TextStyle(color: Colors.black45),
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle:
          const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    );
  }
}