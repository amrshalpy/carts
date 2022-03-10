import 'package:carts/compnement/compnement.dart';
import 'package:carts/moduels/login/cubit/cubit.dart';
import 'package:carts/moduels/login/cubit/state.dart';
import 'package:carts/moduels/login/login.dart';
import 'package:carts/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/undraw_Review_re_kgg1.png',
                        fit: BoxFit.contain,
                        height: 300,
                        width: double.infinity,
                      ),
                      customText(
                        txt: 'Register to buy with 300 million of people ',
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
                              return 'name must be not empty';
                            } else {
                              return null;
                            }
                          },
                          controller: nameController,
                          hint: 'name',
                          type: TextInputType.name,
                          lable: 'name',
                          iconData: Icons.supervised_user_circle),
                      SizedBox(
                        height: 10,
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
                              return 'phone must be not empty';
                            } else {
                              return null;
                            }
                          },
                          controller: phoneController,
                          hint: 'phone',
                          type: TextInputType.phone,
                          lable: 'phone',
                          iconData: Icons.phone),
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
                              cubit.createNewUserWithEmail(
                                  phone: passwordController.text,
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          txt: 'Register'),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          customText(
                              txt: 'if you have an account ',
                              color: greyColor,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                          InkWell(
                            onTap: () {
                              nextPage(context: context, page: Login());
                            },
                            child: customText(
                              txt: 'Login',
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
          ),
        );
      },
    );
  }
}
