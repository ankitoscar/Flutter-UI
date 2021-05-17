import 'package:books_app/Constants/Routes.dart';
import 'package:books_app/Services/Auth.dart';
import 'package:books_app/States/AuthState.dart';
import 'package:books_app/States/EmailState.dart';
import 'package:books_app/States/PasswordState.dart';
import 'package:books_app/Utils/Helpers/not_null.dart';
import 'package:books_app/Widgets/Auth/AuthButton.dart';
import 'package:books_app/Widgets/Auth/AuthErrorMessage.dart';
import 'package:books_app/Widgets/Auth/AuthNavigation.dart';
import 'package:books_app/Widgets/Auth/AuthPageTitle.dart';
import 'package:books_app/Widgets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends AuthState<LoginScreen> with EmailState<LoginScreen>, PasswordState<LoginScreen> {
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<String> onSubmit() async {
    return await this.authService.login(this.email, this.password);
  }

  void onSuccess() {
    print('Logged in successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthNavigation.from(context),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthPageTitle(name: 'Log in'),
            AuthErrorMessage(errorMessage: this.error),
            Form(
              key: this.formKey,
              child: Column(
                children: [EmailTextField(onChanged: this.updateEmail), PasswordTextField(onChanged: this.updatePassword)],
              ),
            ),
            AuthButton(
              text: 'Sign in',
              formKey: this.formKey,
              onClick: this.onSubmit,
              onSuccess: this.onSuccess,
              onError: this.onError,
            ),
            buildForgotPasswordButton(),
            buildRegisterButton(),
          ].where(notNull).toList(),
        )),
      ),
    );
  }

  Widget buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        child: Text("Forgot password?",
            style: GoogleFonts.muli(
              color: Color.fromRGBO(224, 39, 20, 1),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
        onPressed: () {
          Navigator.pushNamed(this.context, Routes.FORGOT_PASSWORD);
        },
      ),
    );
  }

  Widget buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.topRight,
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dont have an account?',
                style: GoogleFonts.muli(color: Colors.black, fontSize: 18),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Register',
                style: GoogleFonts.muli(color: Color.fromRGBO(224, 39, 20, 1), fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(this.context, Routes.REGISTER);
          },
        ),
      ),
    );
  }
}