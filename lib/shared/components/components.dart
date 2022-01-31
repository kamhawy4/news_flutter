import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:news/layout/news_layout.dart';
import 'package:news/main.dart';
import 'package:news/modules/Category/category_screen.dart';
import 'package:news/modules/DetailsArtical/details_screen.dart';
import 'package:news/modules/Home/home_screen.dart';
import 'package:news/modules/Settings/setting_screen.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/locale/cache_helper.dart';
import 'package:news/shared/remote/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget buildArticalItem(titleList, context, index) => BlocConsumer<NewsCubit,
        NewsState>(
    listener: (context, state) {},
    builder: (context, state) {
      var date = DateTime.parse(titleList[index]['created_at']);
      var cubit = NewsCubit.get(context);
      return Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            navigateTo(context, DetailsScreen(titleList[index]));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: NewsCubit.get(context).isDark
                    ? HexColor('4b5154')
                    : Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                      Constants.MainUrlImage + titleList[index]['image']),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(
                          titleList[index]['title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1,
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2, right: 10),
                              child: Container(
                                  child: Text(DateFormat.yMMMd().format(date))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                child: InkWell(
                                  onTap: () {
                                    cubit.AddArticleFavorite(context,titleList[index]['id']);
                                  },
                                child:
                                    Icon(Icons.favorite, color: Colors.amber),
                              ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget articalBuilderSeach(context,artical_type) =>
    BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          NewsCubit.get(context).isLoading = true;
          cubit.GetArticles(context);
          NewsCubit.get(context).isLoading = false;
          return ConditionalBuilder(
              condition:
              cubit.allArticlesSearch != null && cubit.allArticlesSearch.length > 1,
              builder: (context) => ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: cubit.allArticlesSearch.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildArticalItem(cubit.allArticlesSearch['response'],context,index);
                },
              ),
              fallback: (context) {
                return Center(child: Text('Not Foubd Data'));
              });
        });

Widget articalBuilderFavorite(context,artical_type) =>
    BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          NewsCubit.get(context).isLoading = true;
          cubit.GetArticlesFavorite(context);
          NewsCubit.get(context).isLoading = false;
          return ConditionalBuilder(condition:
              cubit.allArticlesFavorite != null && cubit.allArticlesFavorite.length > 0,
              builder: (context) => ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: cubit.allArticlesFavorite['count'],
                itemBuilder: (BuildContext context, int index) {
                  return buildArticalItem(cubit.allArticlesFavorite['response'],context,index);
                },
              ),
              fallback: (context) {
                return Loading();
              });
        });


Widget articalBuilder(context, artical_type) =>
    BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          cubit.GetArticles(context);
          return  ConditionalBuilder(
              condition:
                  cubit.allArticles != null && cubit.allArticles.length > 0,
              builder: (context) => ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cubit.allArticles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildArticalItem(cubit.allArticles['response']['data'],context,index);
                    },
                  ),
              fallback: (context) {
                return Loading();
              });
        });

Widget CustemBar(context, title) => Container(
    height: 70,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(color: Colors.amber),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.black)),
        ),
        SizedBox(width: 130),
        Container(
            child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1,
        )),
      ],
    ));

Widget NavigationBarBottom(pageName) => BlocConsumer<NewsCubit, NewsState>(
    listener: (context, state) {},
    builder: (context, state) {
      var cubit = NewsCubit.get(context);
      var words_lang = AppLocalizations.of(context)!;
      return BottomNavigationBar(
        onTap: (index) {
          cubit.changeBottomNavBar(index, context, pageName);
        },
        currentIndex: cubit.currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: words_lang.home),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.black),
              label: words_lang.search),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.black),
              label: words_lang.favorite),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black),
              label: words_lang.setting),
        ],
      );
    });

Widget Sections() => BlocConsumer<NewsCubit, NewsState>(
    listener: (context, state) {},
    builder: (context, state) {
      var cubit_Sections = NewsCubit.get(context);
      cubit_Sections.GetCategory(context);
      var color_select_Sections =
          cubit_Sections.isDark ? Colors.white : Colors.black;
      var color_unselect_Sections =
          cubit_Sections.isDark ? Colors.white60 : Colors.black38;

      return Container(
        height: 50,
        child: ConditionalBuilder(
          fallback: (context) {
            return Loading();
          },
          condition: cubit_Sections.allCategory != null &&
              cubit_Sections.allCategory.length > 0,
          builder: (context) => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cubit_Sections.allCategory.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    cubit_Sections.changeSections(index, context);
                  },
                  child: Center(
                    child: Text(
                      cubit_Sections.allCategory['response'][index]['name'],
                      style: TextStyle(
                          fontSize: 16,
                          shadows: [
                            Shadow(
                                color: cubit_Sections.currentSections == index
                                    ? color_select_Sections
                                    : color_unselect_Sections,
                                offset: Offset(0, -9))
                          ],
                          decoration: TextDecoration.underline,
                          decorationColor:
                              cubit_Sections.currentSections == index
                                  ? Colors.amber
                                  : Colors.transparent,
                          decorationThickness: 4,
                          decorationStyle: TextDecorationStyle.solid,
                          color: Colors.transparent),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });

Widget changeLang(context) => BlocConsumer<NewsCubit, NewsState>(
    listener: (context, state) {},
    builder: (context, state) {
      var cubit = NewsCubit.get(context);
      return InkWell(
        onTap: () {
          if (cubit.localizations == 'ar') {
            NewsCubit.get(context).changeAppLang(
              context,
              fromShared: 'en',
            );
          } else if (cubit.localizations == 'en') {
            NewsCubit.get(context).changeAppLang(context, fromShared: 'ar');
          }
        },
        child: Text(cubit.localizations == 'en' ? 'Arabic' : 'English',
            style: Theme.of(context).textTheme.bodyText1),
      );
    });

Widget Loading() => SpinKitThreeInOut(
      color: Colors.amber,
      size: 50.0,
    );

ShowSnackBarError(context,Message) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: HexColor('#a94442'),
        content: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Expanded(
              child:Text(
                Message,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );

ShowSnackBarSuccess(context,Message) => ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: HexColor('#42a944'),
    content: Row(
      children: [
        Icon(
          Icons.check,
          color: Colors.white,
        ),
        SizedBox(width: 10),
        Expanded(
          child:Text(
            Message,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  ),
);