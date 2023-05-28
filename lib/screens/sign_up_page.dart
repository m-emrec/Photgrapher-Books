import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_book/extensions/sized_box_extension.dart';
import 'package:photo_book/logger.dart';
import 'package:photo_book/models/user_model.dart';
import 'package:photo_book/utils/form_section.dart';
import 'package:photo_book/utils/logo_section.dart';
import 'package:photo_book/utils/text_input_field.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  static const routeName = "sign-up-page";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController studioNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? _commonValidator(String val) {
    if (val.isEmpty || val.startsWith(" ")) {
      return "This field can't be empty !";
    } else {
      return null;
    }
  }

  String? _emailValidator(String val) {
    if (!EmailValidator.validate(val)) {
      return "Please write a valid Email !";
    }
    return null;
  }

  String? _passwordValidator(String val) {
    if (val.length < 6) {
      return "Your password must be longer than 6 char!";
    }
    return null;
  }

  Future<void> _createAccount(BuildContext context, UserModel user) async {
    try {
      // Create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      final User? currrentUser = FirebaseAuth.instance.currentUser;
      await currrentUser!.updateDisplayName(user.name);

      // add additional infos of the User
      await FirebaseFirestore.instance.collection("Users").add({
        "id": currrentUser.uid,
        "phoneNumber": user.phoneNumber,
        "studioName": user.studioName,
        "address": user.address,
      });
    } on FirebaseAuthException catch (e) {
      logger.e(e);
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
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (size.height * 0.05).ph(),
                const LogoWidget(),

                (size.height * 0.05).ph(),
                // Title
                Text(
                  "Create Account",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                FormSection(
                  fields: [
                    InputField(
                      label: "Name",
                      controller: nameController,
                      inputAction: TextInputAction.next,
                      validatorFunc: _commonValidator,
                      keyboardType: TextInputType.name,
                      makeCapital: true,
                    ),
                    InputField(
                      label: "Phone Number",
                      controller: numberController,
                      validatorFunc: _commonValidator,
                      inputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                    ),
                    InputField(
                      label: "Studio Name",
                      controller: studioNameController,
                      validatorFunc: _commonValidator,
                      inputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      makeCapital: true,
                    ),
                    InputField(
                      label: "Email",
                      controller: emailController,
                      inputAction: TextInputAction.next,
                      validatorFunc: _emailValidator,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    InputField(
                      label: "Address",
                      controller: addressController,
                      validatorFunc: _commonValidator,
                      inputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,
                      makeCapital: true,
                    ),
                    InputField(
                      label: "Password",
                      controller: passwordController,
                      inputAction: TextInputAction.done,
                      validatorFunc: _passwordValidator,
                      isPassword: true,
                    ),
                  ],
                  formKey: formKey,
                ),
                32.ph(),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        // Not Valid
                        logger.e("Not validated");
                      } else {
                        // Valid
                        await _createAccount(
                          context,
                          UserModel(
                            name: nameController.text,
                            email: emailController.text,
                            phoneNumber: numberController.text,
                            studioName: studioNameController.text,
                            address: addressController.text,
                            password: passwordController.text,
                          ),
                        ).then(
                          (value) =>
                              Navigator.of(context).pushReplacementNamed("/"),
                        );
                      }
                    },
                    child: const Text("Register"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
