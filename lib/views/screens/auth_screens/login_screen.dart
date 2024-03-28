import 'package:evitalrx_test/controller/auth_controller.dart';
import 'package:evitalrx_test/utils/constant.dart';
import 'package:evitalrx_test/views/components/common_button.dart';
import 'package:evitalrx_test/views/components/common_text.dart';
import 'package:evitalrx_test/views/components/common_textfield.dart';
import 'package:evitalrx_test/views/screens/home_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final authCon = Get.put<AuthController>(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const CommonText(
          text: "Login",
          letterSpacing: 1,
          fontSize: 18,
          color: AppColor.white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: Get.height * 0.12),
              const CommonText(
                text: "Let’s get Started",
                color: AppColor.secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 26,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              CommonText(
                text: "Please enter your mobile number &\n password to login ",
                color: AppColor.primaryColor,
                fontSize: Get.height > 680 ? 15 : 16,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CommonTextField(
                con: authCon.mobileNumberCon,
                fillColor: AppColor.white,
                borderColor: AppColor.grey,
                labelText: "Enter Mobile Number",
                keyBoardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(errorText: "Please enter mobile number"),
                    FormBuilderValidators.minLength(10, errorText: "Please enter 10 digit mobile number"),
                    (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter mobile number";
                      }
                      if (value != authCon.mobileValid) {
                        return 'Please enter a valid mobile number';
                      }
                      return null;
                    }
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CommonTextField(
                con: authCon.passcodeCon,
                fillColor: AppColor.white,
                borderColor: AppColor.grey,
                labelText: "Enter password",
                keyBoardType: TextInputType.text,
                inputFormatters: [LengthLimitingTextInputFormatter(12)],
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(errorText: "Please enter password"),
                    FormBuilderValidators.minLength(
                      6,
                      errorText: "Password is not valid. Please enter a minimum of 6 digits",
                    ),
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value != authCon.passValid) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    }
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CommonButton(
                label: "Login",
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Get.offAll(() => const HomeScreen());
                  }
                },
              ),
              SizedBox(height: Get.height * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}
