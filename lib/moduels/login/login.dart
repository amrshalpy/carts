import 'package:carts/compnement/compnement.dart';
import 'package:carts/moduels/home/home.dart';
import 'package:carts/moduels/login/cubit/cubit.dart';
import 'package:carts/moduels/login/cubit/state.dart';
import 'package:carts/moduels/register/register.dart';
import 'package:carts/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginWithEmailSucsses ||
            state is LoginWithFacebookSucsses ||
            state is LoginWithGoogleSucsses) {
          nextPageUntil(context: context, page: Home());
        }
      },
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return SafeArea(
          child: Scaffold(
            key: formKey,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/undraw_Review_re_kgg1.png',
                      fit: BoxFit.contain,
                      height: 300,
                      width: double.infinity,
                    ),
                    customText(
                      txt: 'Login to buy with 300 million of people ',
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    buildFormField(
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'email must be not empty';
                          } else {
                            return null;
                          }
                        },
                        controller: emailController,
                        hint: 'Email Address',
                        type: TextInputType.emailAddress,
                        lable: 'Email Address',
                        iconData: Icons.email_outlined),
                    SizedBox(
                      height: 10,
                    ),
                    buildFormField(
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'password must be not empty';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        hint: 'Password',
                        type: TextInputType.visiblePassword,
                        lable: 'Password',
                        iconData: Icons.vpn_lock),
                    SizedBox(
                      height: 18,
                    ),
                    button(
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            cubit.loginWithEmail(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        txt: 'Login'),
                    SizedBox(
                      height: 18,
                    ),
                    customText(
                      txt: '_ OR _',
                      color: blacColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            cubit.loginWithFacebook();
                          },
                          child: Image.asset(
                            'assets/images/facebook.png',
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            cubit.loginWithGoogle();
                          },
                          child: Image.asset(
                            'assets/images/google.png',
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        customText(
                            txt: 'if you have\ nt an account ',
                            color: greyColor,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        InkWell(
                          onTap: () {
                            nextPage(context: context, page: Register());
                          },
                          child: customText(
                            txt: 'Register',
                            color: blacColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
