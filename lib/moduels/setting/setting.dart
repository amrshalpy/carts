import 'package:carts/compnement/compnement.dart';
import 'package:carts/home_cubit/home_cubit.dart';
import 'package:carts/home_cubit/home_state.dart';
import 'package:carts/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Setting extends StatelessWidget {
  Setting({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 230,
                width: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Image.network(
                        'https://img.freepik.com/free-photo/portrait-joyful-young-man-white-shirt_171337-17467.jpg?w=740',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: whiteColor,
                        ),
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/portrait-joyful-young-man-white-shirt_171337-17467.jpg?w=740',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Form(
                key: formKey,
                child: Column(children: [
                  buildFormField(
                    validate: (String? val) {
                      if (val!.isEmpty) {
                        return 'this field must be not empty';
                      } else {
                        return null;
                      }
                    },
                    controller: nameController,
                    hint: 'name',
                    type: TextInputType.name,
                    lable: 'name',
                    iconData: Icons.verified_user,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildFormField(
                    validate: (String? val) {
                      if (val!.isEmpty) {
                        return 'this field must be not empty';
                      } else {
                        return null;
                      }
                    },
                    controller: bioController,
                    hint: 'bio',
                    type: TextInputType.name,
                    lable: 'bio',
                    iconData: Icons.biotech,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
              ),
              button(
                onPress: () {
                  HomeCubit.get(context).saveUserData(
                    bio: bioController.text,
                    name: nameController.text,
                  );
                },
                txt: 'update data',
              ),
            ],
          ),
        );
      },
    );
  }
}
