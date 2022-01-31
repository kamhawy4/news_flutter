import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/layout/news_layout.dart';
import 'package:news/shared/components/components.dart';
import '../Home/home_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
       Padding(
         padding: const EdgeInsets.all(10),
         child: ListView(
           physics: BouncingScrollPhysics(),
           children: [
             Padding(
               padding: const EdgeInsets.all(10),
               child: Container(
                   alignment: Alignment.bottomLeft,
                   width: MediaQuery.of(context).size.width / 5,
                   height: 30,
                   child: Image.asset('assets/images/logo.png')),
             ),
             Sections(),
             articalBuilder(context,'id')
           ],
         ),
       ),
        bottomNavigationBar: NavigationBarBottom('internalScreen')
    );
  }
}
