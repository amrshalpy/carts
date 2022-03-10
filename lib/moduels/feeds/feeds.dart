import 'package:carts/compnement/compnement.dart';
import 'package:carts/home_cubit/home_cubit.dart';
import 'package:carts/home_cubit/home_state.dart';
import 'package:carts/moduels/feeds/widgets/get_feed.dart';
import 'package:carts/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()
        ..getPosts()
        ..getUsers(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return cubit.postModel != null || cubit.userModel != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      cubit.posts != null
                          ? ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  getFeed(cubit.posts[index]),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 5,
                              ),
                              itemCount: cubit.posts.length,
                              shrinkWrap: true,
                            )
                          : CircularProgressIndicator(),
                    ],
                  ),
                )
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
