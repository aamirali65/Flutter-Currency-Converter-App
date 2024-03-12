import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String customText;
  final VoidCallback onTap;
  final bool loading;
  const CustomButton({Key? key, required this.customText, required this.onTap, this.loading=false}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xff182D9E),
          borderRadius: BorderRadius.circular(10),
        ),
    child: Center(child: widget.loading ?  const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)) : Text(widget.customText,style:const TextStyle(color: Colors.white,fontFamily: 'Lexend'),),),
      ),
    );
  }
}
