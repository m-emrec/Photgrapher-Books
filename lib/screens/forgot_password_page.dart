import 'package:flutter/material.dart';
import 'package:photo_book/extensions/sized_box_extension.dart';
import 'package:photo_book/utils/form_section.dart';
import 'package:photo_book/utils/logo_section.dart';
import 'package:photo_book/utils/text_input_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  static const routeName = "forgot-password-page";

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController mobileNumberController = TextEditingController();

  final TextEditingController otpController = TextEditingController();

  bool showOtpField = false;

  void getOtp() {
    //TODO: Add firebase verification message func.
    setState(() {
      showOtpField = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: size.height,
          width: size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (size.height * 0.05).ph(),
                //Logo
                const LogoWidget(),
                (size.height * 0.05).ph(),
                // Title
                Text(
                  "Forgot Password",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                32.ph(),
                // Form Field
                FormSection(
                  fields: [
                    InputField(
                      label: "Mobile Number",
                      controller: mobileNumberController,
                      keyboardType: TextInputType.phone,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: getOtp,
                        child: const Text("Get OTP"),
                      ),
                    ),
                    Visibility(
                      visible: showOtpField,
                      child: InputField(
                        label: "OTP",
                        controller: otpController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                          signed: false,
                        ),
                      ),
                    ),
                  ],
                  formKey: formKey,
                ),
                32.ph(),
                const SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text("Submit"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
