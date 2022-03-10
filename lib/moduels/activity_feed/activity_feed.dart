import 'package:carts/home_cubit/home_cubit.dart';
import 'package:carts/home_cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityFeed extends StatelessWidget {
  const ActivityFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column();
      },
    );
  }
}
