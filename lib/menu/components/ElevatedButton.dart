import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final Function onPressed;
  final String label;
  const CustomElevatedButton({super.key, required this.onPressed, required this.label});

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {

  double _buttonElevation = 12.0;

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onPressed.call(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        elevation: 12.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: const BorderSide(
            color: Colors.white,
            width: 4.0,
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 60.0,
        width: 200.0,

        child: Text(
          widget.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}