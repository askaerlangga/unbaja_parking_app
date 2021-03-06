import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;

  const CustomButton(
      {required String this.label,
      this.icon,
      required this.onPressed,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: MaterialButton(
          color: Colors.orange,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
              const Spacer(
                flex: 9,
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const Spacer(
                flex: 10,
              ),
            ],
          ),
        ));
  }
}
