import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/locale/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'layout/news_layout.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'modules/Auth/login_screen.dart';


void  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  bool isDark = CacheHelper.getBoolean(key: 'isDark');

  String lang = CacheHelper.getValue(key: 'lang');

  String token = CacheHelper.getValue(key: 'token');

  runApp(MyApp(lang,isDark,token));

}

class MyApp extends StatelessWidget {
  final bool isDark;
  final String lang;
  final String token;
  MyApp(this.lang, this.isDark,this.token);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsCubit()..changeAppMode(  fromShared: isDark)),
      ],
      child: BlocConsumer<NewsCubit,NewsState>(
          listener: (context,state){},
        builder: (context, snapshot) {

          return MaterialApp(
            locale: Locale(NewsCubit.get(context).localizations),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.amber,
              scaffoldBackgroundColor: HexColor('#D3D3D3'),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  selectedLabelStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),
                  selectedIconTheme: IconThemeData(
                      size: 30
                  ),
                  backgroundColor: Colors.amber,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.black,
                  type: BottomNavigationBarType.fixed),
              textTheme: TextTheme(
                bodyText1: GoogleFonts.lato(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.amber,
              scaffoldBackgroundColor: HexColor('333739'),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  selectedLabelStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),
                  selectedIconTheme: IconThemeData(
                      size: 30
                  ),
                  backgroundColor: Colors.amber,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.black,
                  type: BottomNavigationBarType.fixed),
              textTheme: TextTheme(
                bodyText1: GoogleFonts.lato(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: ThemeMode.light,
            home: token == null ? LoginScreen() :  NewsLayout(),
          );
        }
      ),
    );
  }
}
