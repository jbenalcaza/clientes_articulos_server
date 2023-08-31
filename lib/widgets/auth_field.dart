import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final String value;
  final Map<String, String> formValues;
  final bool isPassword;
  final bool? autofocus;
  final double width;
  final Color? color;
  final String? initValue;
  final TextInputType? textInputType;
  final Function? validator;

  const AuthField(
      {Key? key,
      required this.hintText,
      required this.value,
      required this.formValues,
      this.isPassword = false,
      this.width = 0,
      this.color, //= const Color(0xff7F7F79),
      this.initValue,
      this.autofocus = false,
      this.textInputType,
      this.validator})
      : super(key: key);

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.width != 0
            ? widget.width!
            : size.width > 600
                ? size.width * 0.4
                : size.width * 0.8,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              widget.hintText,
              style: TextStyle(
                color: widget.color,
                fontSize: size.height > size.width
                    ? size.height * 0.02
                    : size.height * 0.025,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: TextFormField(
              autofocus: widget.autofocus!,
              initialValue: widget.initValue,
              keyboardType: widget.textInputType,
              style: const TextStyle(
                color: Colors.black,
              ),
              obscureText: widget.isPassword ? !isPasswordVisible : false,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 27, vertical: 18),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        padding: const EdgeInsets.only(right: 40),
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black26,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                widget.formValues[widget.value] = value;
              },
              validator: (value) {
                widget.validator;
              },
            ),
          ),
        ],
      ),
    );
  }
}
