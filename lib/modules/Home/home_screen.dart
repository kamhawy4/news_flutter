import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/layout/news_layout.dart';
import 'package:news/shared/components/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/shared/cubit/cubit.dart';
import '../Category/category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];


  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
     var words_lang = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(10),
      child:  ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.bottomLeft,
                    width: MediaQuery.of(context).size.width / 5,
                    height: 30,
                    child: Image.asset('assets/images/logo.png')),
              ),
              // changeLang(context),
            ],
          ),
          Sections(),
          Container(
            child: CarouselSlider.builder(
              itemCount: imgList.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Stack(
                children: [
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imgList[itemIndex],
                          height: heightScreen,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,bottom: 10),
                      child: Text(
                        'What is Lorem Ipsum?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Align(
                    heightFactor: 2,
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: Icon(Icons.favorite, color: Colors.white),
                    ),
                  ),
                  Align(
                    heightFactor: 2,
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        '3 hours ago',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayInterval: Duration(seconds: 3),
                viewportFraction: 0.7,
                aspectRatio: 2.0,
                initialPage: 0,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(words_lang.latestNews,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          articalBuilder(context,'recent')
        ],
      ),
    );
  }
}
