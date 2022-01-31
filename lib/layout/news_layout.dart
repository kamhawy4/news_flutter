import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/Favorite/favorite_screeen.dart';
import 'package:news/modules/Home/home_screen.dart';
import 'package:news/modules/Search/search_screen.dart';
import 'package:news/modules/Settings/setting_screen.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<NewsCubit, NewsState>(
     listener: (context, state) {},
    builder: (context, state) {
      var cubit = NewsCubit.get(context);
      return Scaffold(
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: NavigationBarBottom('layout')
      );
    }
   );
  }
}
