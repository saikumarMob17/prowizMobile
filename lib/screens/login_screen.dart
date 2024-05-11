import 'package:flutter/material.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/images.dart';
import 'package:prowiz/utils/strings.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(48),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100, width: 100, child: FlutterLogo()),
              const SizedBox(
                height: 25,
              ),
              RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: Constants.welcomeBackText,
                      style: TextStyle(color: ConstantColors.blackColor)),
                  WidgetSpan(
                      child: SizedBox(
                    width: 5,
                  )),
                  TextSpan(
                      text: Constants.login,
                      style: TextStyle(color: ConstantColors.loginTextColor)),
                ]),
              ),
              const SizedBox(
                height: 30,
              ),
              userNameField(),
              const SizedBox(
                height: 20,
              ),
              passwordField(),
              SizedBox(
                height: 30,
              ),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  var focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none);

  var contentPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5);

  var hintTextStyle = const TextStyle(fontSize: 12, color: Colors.black12);
  userNameField() {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          hintText: Constants.userName,
          hintStyle: hintTextStyle,
          contentPadding: contentPadding,
          fillColor: ConstantColors.textFieldColor,
          focusedBorder: focusBorder,
          border: focusBorder),
    );
  }

  passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        hintText: Constants.password,
        hintStyle: hintTextStyle,
        fillColor: ConstantColors.textFieldColor,
        contentPadding: contentPadding,
        focusedBorder: focusBorder,
        border: focusBorder,
      ),
    );
  }

  submitButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: ConstantColors.buttonColor,
        ),
        onPressed: () {},
        child: Text(
          Constants.submit,
          style: TextStyle(color: Colors.white),
        ));
  }
}
