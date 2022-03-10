import 'package:carts/home_cubit/home_cubit.dart';
import 'package:carts/home_cubit/home_state.dart';
import 'package:carts/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: cubit.title[cubit.currentIndex],
            elevation: 0,
            backgroundColor: whiteColor,
            titleTextStyle: TextStyle(
              color: blacColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.notification_important,
                ),
                label: 'ActivityFeed',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.post_add,
                ),
                label: 'Posts',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.chat_rounded),
                label: 'Chat',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeCurrentIndex(index, context);
            },
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }
}
