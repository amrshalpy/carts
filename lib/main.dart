import 'package:carts/compnement/const.dart';
import 'package:carts/compnement/constants.dart';
import 'package:carts/home_cubit/home_cubit.dart';
import 'package:carts/moduels/home/home.dart';
import 'package:carts/moduels/login/cubit/cubit.dart';
import 'package:carts/moduels/login/login.dart';
import 'package:carts/share/local/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uid = CacheHelper.getData(kUid);
  print('uid = $uid');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
        BlocProvider<HomeCubit>(
            create: (context) => HomeCubit()
              ..getAdmin()
              ..getPosts()
              ..getUsers())
      ],
      //hello
      child: MaterialApp(
        title: 'Shopping Cart',
        home: Login(),
      ),
    );
  }
}
