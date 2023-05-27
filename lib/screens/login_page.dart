import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:photo_book/extensions/image_path_extension.dart';
import 'package:photo_book/extensions/sized_box_extension.dart';
import 'package:photo_book/logger.dart';
import 'package:photo_book/utils/text_input_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? validateEmail(String val) {
    if (!EmailValidator.validate(val)) {
      return " Please enter valid email.";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * 0.9,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (size.height * 0.05).ph(),
                // Logo
                Image.asset(
                  "logo".toPng(),
                  height: size.height * 0.2,
                  width: size.width * 0.6,
                  fit: BoxFit.fill,
                ),
                (size.height * 0.05).ph(),
                // Title
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // Form Field
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 32.0,
                    ),
                    child: Column(
                      children: [
                        //email field
                        InputField(
                          label: "Email",
                          keyboardType: TextInputType.emailAddress,
                          validatorFunc: validateEmail,
                          controller: emailController,
                          inputAction: TextInputAction.next,
                        ),
                        16.ph(),
                        // password Field
                        InputField(
                          label: "Password",
                          isPassword: true,
                          controller: passwordController,
                        ),
                      ],
                    ),
                  ),
                ),

                //Forgot Pasword
                const Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: null,
                    child: Text(
                      "Forgot Password ?",
                    ),
                  ),
                ),

                // Login Button
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        logger.i("Yep");
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
                16.ph(),
                // New User
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New User?"),
                    TextButton(
                      onPressed: null,
                      child: Text(
                        "Create an account.",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
