import 'dart:io';

import 'package:carts/compnement/compnement.dart';
import 'package:carts/home_cubit/home_cubit.dart';
import 'package:carts/home_cubit/home_state.dart';
import 'package:carts/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Posts extends StatelessWidget {
  Posts({Key? key}) : super(key: key);
  var txtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()
        ..getUsers()
        ..getPosts(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: whiteColor,
              iconTheme: IconThemeData(color: blacColor),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                          maxLength: null,
                          controller: txtController,
                          decoration: InputDecoration(
                            hintText: 'write something here',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              cubit.imagePost != null
                                  ? cubit.storageImagePost(
                                      date: DateTime.now().toString(),
                                      text: txtController.text,
                                    )
                                  : cubit.savePostData(
                                      date: DateTime.now().toString(),
                                      text: txtController.text,
                                    );
                              txtController.clear();
                              cubit.removeImagePost();
                              pop(context: context);
                            },
                            icon: Icon(Icons.send)),
                      )
                    ],
                  ),
                  Spacer(),
                  Container(
                    child: Stack(
                      children: [
                        cubit.imagePost == null
                            ? Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
                                fit: BoxFit.contain,
                                height: 150,
                                width: double.infinity,
                              )
                            : Image.file(
                                File(cubit.imagePost!.path),
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                        if (cubit.imagePost != null)
                          IconButton(
                              onPressed: () {
                                cubit.removeImagePost();
                              },
                              icon: Icon(Icons.clear)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          cubit.uploadImagePost();
                        },
                        child: Container(
                          height: 50,
                          width: 120,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Add Image',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: whiteColor,
                                  ),
                                ),
                                Icon(
                                  Icons.image,
                                  color: greyColor,
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: mainColor,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 100,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'tags',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text('#'),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: greyColor,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
