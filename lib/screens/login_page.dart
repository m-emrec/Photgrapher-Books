import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photo_book/extensions/sized_box_extension.dart';
import 'package:photo_book/logger.dart';
import 'package:photo_book/screens/forgot_password_page.dart';
import 'package:photo_book/screens/sign_up_page.dart';
import 'package:photo_book/utils/form_section.dart';
import 'package:photo_book/utils/logo_section.dart';
import 'package:photo_book/utils/text_input_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static const routeName = "login-page";

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

  Future<void> loginToAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      logger.e(e);
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
                const LogoWidget(),
                (size.height * 0.05).ph(),
                // Title
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                32.ph(),
                // Form Field
                FormSection(
                  fields: [
                    InputField(
                      label: "Email",
                      keyboardType: TextInputType.emailAddress,
                      validatorFunc: validateEmail,
                      controller: emailController,
                      inputAction: TextInputAction.next,
                    ),
                    // password Field
                    InputField(
                      label: "Password",
                      isPassword: true,
                      controller: passwordController,
                    ),
                  ],
                  formKey: formKey,
                ),

                //Forgot Pasword
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(ForgotPasswordPage.routeName),
                    child: const Text(
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
                        showDialog(
                          useRootNavigator: true,
                          context: context,
                          builder: (_) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                        loginToAccount(
                                emailController.text, passwordController.text)
                            .then(
                          (value) =>
                              Navigator.of(context).pushReplacementNamed("/"),
                        );
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
                16.ph(),
                // New User Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("New User?"),
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(SignUpPage.routeName),
                      child: const Text(
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
