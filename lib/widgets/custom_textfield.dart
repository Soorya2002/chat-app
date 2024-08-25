import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? leadingIcon;
  final Icon? trailingIcon;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.leadingIcon,
    this.trailingIcon,
    this.isPassword = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.06,
        vertical: screenHeight * 0.01,
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _isObscured : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.green.withOpacity(0.5),
          ),
          prefixIcon: widget.leadingIcon != null
              ? Icon(
                  widget.leadingIcon!.icon,
                  size: screenHeight * 0.03,
                  color: Colors.green.withOpacity(0.5),
                )
              : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: Colors.green.withOpacity(0.5),
                    size: screenHeight * 0.03,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                )
              : widget.trailingIcon != null
                  ? Icon(
                      widget.trailingIcon!.icon,
                      size: screenHeight * 0.03,
                      color: Colors.green[700],
                    )
                  : null,
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey, width: screenWidth * 0.002),
            borderRadius: BorderRadius.circular(screenHeight * 0.03),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * 0.03),
            borderSide: BorderSide(
                color: Colors.green.withOpacity(0.5),
                width: screenWidth * 0.003),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenHeight * 0.03),
            borderSide: BorderSide(
                color: Colors.green.withOpacity(0.5),
                width: screenWidth * 0.002),
          ),
        ),
        cursorColor: Colors.green.withOpacity(0.7),
      ),
    );
  }
}
