import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_text_field.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthScreens extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreens({super.key});

  @override
  State<AuthScreens> createState() => _AuthScreensState();
}

enum OptionChoosed { createAccount, signIn }

class _AuthScreensState extends State<AuthScreens> {
  OptionChoosed opt = OptionChoosed.createAccount;
  final _createAccountFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void signUpUser() {
    // if(mounted)
    if(mounted){
      authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
      );
    }
  }
  void signInUser() {
    // if(mounted)
    if(mounted){
      authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              ListTile(
                tileColor: opt == OptionChoosed.createAccount
                    ? Colors.white
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  "Create Account",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: opt,
                  groupValue: OptionChoosed.createAccount,
                  onChanged: (val) {
                    setState(() {
                      opt = OptionChoosed.createAccount;
                    });
                  },
                ),
              ),
              if (opt == OptionChoosed.createAccount)
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _createAccountFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          textEditingController: _nameController,
                          hint: "Name",
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                            textEditingController: _emailController,
                            hint: "Email"),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          textEditingController: _passwordController,
                          hint: "Password",
                        ),
                        CustomButton(
                          text: "Create Account",
                          onTap: () {
                            if(_createAccountFormKey.currentState!.validate()){
                              signUpUser();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: opt == OptionChoosed.signIn
                    ? Colors.white
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  "Sign In",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: opt,
                  groupValue: OptionChoosed.signIn,
                  onChanged: (val) {
                    setState(() {
                      opt = OptionChoosed.signIn;
                    });
                  },
                ),
              ),
              if (opt == OptionChoosed.signIn)
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            textEditingController: _emailController,
                            hint: "Email"),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          textEditingController: _passwordController,
                          hint: "Password",
                        ),
                        CustomButton(
                          text: "Sign In",
                          onTap: () {
                            if(_signInFormKey.currentState!.validate()){
                              signInUser();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
