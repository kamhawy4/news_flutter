import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news/layout/news_layout.dart';
import 'package:news/model/model.dart';
import 'package:news/modules/Auth/forget_password_screen.dart';
import 'package:news/modules/Auth/register_screen.dart';
import 'package:news/modules/Category/category_screen.dart';
import 'package:news/modules/Comments/comments_screen.dart';
import 'package:news/modules/DetailsArtical/details_screen.dart';
import 'package:news/modules/Favorite/favorite_screeen.dart';
import 'package:news/modules/Home/home_screen.dart';
import 'package:news/modules/Search/search_screen.dart';
import 'package:news/modules/Settings/setting_screen.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/locale/cache_helper.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:news/shared/remote/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsCubit extends Cubit<NewsState> {

  NewsCubit() : super(NewsInitialState());


  static NewsCubit get(context) => BlocProvider.of(context);

  var localizations  = CacheHelper.getValue(key: 'lang');

  // data user
  var token =  CacheHelper.getValue(key: 'token');
  var name =  CacheHelper.getValue(key: 'name');
  var email =  CacheHelper.getValue(key: 'email');
  var phone =  CacheHelper.getValue(key: 'phone');
  var id =  CacheHelper.getValue(key: 'id');

  int currentIndex = 0;

  bool isLoading = true;

  int currentSections = 0;

  // screens  Bottom NavBar

  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    FavoriteScreen(),
    SettingScreen(
      onChanged: (bool value) {},
      value: false,
    ),
  ];

  // change tap in  Bottom NavBar
  void changeBottomNavBar(int index, context, pageName) {
    currentIndex = index;


    if (index == 0) {
      currentSections = 0;
      HomeScreen();
      if (pageName != 'layout') {
        navigateTo(context, NewsLayout());
      }
    }

    if (index == 1) {
      SearchScreen();
      if (pageName != 'layout') {
        navigateTo(context, NewsLayout());
      }
    }

    if (index == 2) {
      FavoriteScreen();
      if (pageName != 'layout') {
        navigateTo(context, NewsLayout());
      }
    }

    if (index == 3) {
      SettingScreen(onChanged: (bool value) {}, value: false);
      if (pageName != 'layout') {
        navigateTo(context, NewsLayout());
      }
    }
    emit(NewsBottomNavState());
  }

  // when you want go to other category in from list this there in top slider
  void changeSections(index, context) {
    currentSections = index;
    if (index == 0) {
      navigateTo(context, NewsLayout());
    } else {
      navigateTo(context, CategoryScreen());
    }
    emit(NewsChangeSectionState());
  }

  // change language
  void changeAppLang(context,{String? fromShared}) {
    localizations = fromShared;
    CacheHelper.putValue(key: 'lang', value: localizations!);
    emit(NewsChangeLangState());
    GetCategory(context);
    GetArticles(context);
    navigateTo(context, NewsLayout());
  }

  // change ThemMode
  bool isDark = false;
  void changeAppMode({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
      emit(AppChangeModeState());
    }else{
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark);
      emit(AppChangeModeState());
    }
  }


  // get all tags by api by use http package
  Future<void> GetTag() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'tags');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  // get all Category by api by use http package
  var  allCategory;
  Future<void> GetCategory(context) async {
    NewsCubit.get(context).isLoading = true;
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'categories');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url,headers: {
      'X-localization': localizations
    });
    if (response.statusCode == 200) {

      allCategory =  convert.jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  var allArticles;
  Future<void> GetArticles(context) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'artical/recent');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url,headers: {
      'X-localization': localizations,
    });
    if (response.statusCode == 200) {
      allArticles =   convert.jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }



    // get all Articals according type by api by use http package
  // get all Articals according type by api by use http package
  var allArticlesSearch;
  Future<void> GetArticlesSearch(context,text) async {
    emit(NewsGetSearchSuccessState());
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'artical/search/'+text);
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    print(url);
    if (response.statusCode == 200) {
      allArticlesSearch =   convert.jsonDecode(response.body);
      emit(NewsGetSearchSuccessState());
    } else {
      allArticlesSearch =   convert.jsonDecode(response.body);
      emit(NewsGetSearchErrorState());
     // print(allArticlesSearch);
      // print('Request failed with status: ${response.statusCode}.');
    }
  }


  // get all Articals according type by api by use http package
  var allArticlesFavorite;
  Future<void> GetArticlesFavorite(context) async {

    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'article/favorite/get/'+id);

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url,headers: {
      'X-localization': localizations,
      'Authorization': 'Bearer ' + token,
    });
    if (response.statusCode == 200) {
      allArticlesFavorite =   convert.jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  var allComments;
  // get all Articl Comments by api by use http package
  Future<void> ArticlComments(artical_id) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'article/comments/show/'+artical_id);

    //Await the http get response, then decode the json-formatted response.
    var response = await http.get(url,headers: {
      'X-localization': localizations,
      'Authorization': 'Bearer ' + token,
    });
    if (response.statusCode == 200) {
      allComments =  convert.jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  // get all Articl Comments by api by use http package
  Future<void> SendArticlComments(comment,id) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'article/comments/store');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url,headers: {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer ' + token,
    },
      body: jsonEncode(<String, String>{
        'title': comment,
        'name' : 'User Sky',
        'article_id':id
      }),);
    if (response.statusCode == 200) {
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  // SignUp
  Future<void> SignUp(context,name,email,phone,password,password_confirmation) async {
   // var data = ModelSignUp();
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'user/signup');
    //Await the http get response, then decode the json-formatted response.
    var response = await http.post(url,headers: {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    }, body: jsonEncode(<String, String>{
           'name': name.text,
           'email': email.text,
           'phone':phone.text,
           'password': password.text,
           'password_confirmation': password_confirmation.text
       }),);
     if (response.statusCode == 201) {
       final result = jsonDecode(response.body) as Map<String, dynamic>;
       ShowSnackBarSuccess(context,result['message']);
     } else {
       final result = jsonDecode(response.body) as Map<String, dynamic>;
       ShowSnackBarError(context,result['message']);
       print('Request failed with status: ${response.statusCode}.');
     }
  }


  // Edituser
  Future<void> Edituser(context,userName,userEmail,userPhone,userPassword) async {
    //This example uses the Google Books API to search for books about http.
    //https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'user/update/'+id);
    //Await the http get response, then decode the json-formatted response.
    var response = await http.post(url,headers: {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer ' + token,
    }, body: jsonEncode(<String, String>{
      'name': userName.text,
      'email': userEmail.text,
      'phone': userPhone.text,
      'password': userPassword.text,
    }),);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      print(result['response']['name']);
      name = result['response']['name'];
      email = result['response']['email'];
      phone = result['response']['phone'];
      ShowSnackBarSuccess(context,'User Edit Successfully');
    } else {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      ShowSnackBarError(context,result['message']);
      print('Request failed with status: ${response.statusCode}.');
    }
  }



  // SignUp
  Future<void> AddArticleFavorite(context,artical_id) async {
    //This example uses the Google Books API to search for books about http.
    //https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'article/favorite/store');
    //Await the http get response, then decode the json-formatted response.
    var response = await http.post(url,headers: {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer ' + token,
    }, body: jsonEncode(<String, int>{
      'user_id': int.parse(id) ,
      'articles_id': artical_id,
    }),);
    if (response.statusCode == 200) {
      ShowSnackBarSuccess(context,'Add Favorite Successfully');
    } else {
      ShowSnackBarError(context,'Something Wrong');
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  // Forget Password
  Future<void> SignIn(context,email,password) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'user/login');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url,headers: {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest'
    },
      body: jsonEncode(<String, String>{
        'email': email.text,
        'password' : password.text
      }),);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      CacheHelper.putValue(key: 'token', value: result['access_token']);
      GrtDdataUser();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => NewsLayout()));
    } else {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      ShowSnackBarError(context,result['message']);
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  // get all Articl Comments by api by use http package
  Future<void> GrtDdataUser() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'user');

    //Await the http get response, then decode the json-formatted response.
    var response = await http.get(url,headers: {
      'X-localization': localizations,
      'Authorization': 'Bearer ' + token,
    });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      CacheHelper.putValue(key: 'name', value: result['response']['name'].toString());
      CacheHelper.putValue(key: 'email', value: result['response']['email'].toString());
      CacheHelper.putValue(key: 'phone', value: result['response']['phone'].toString());
      CacheHelper.putValue(key: 'id', value: result['response']['id'].toString());
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }



  // Forget Password
  Future<void> ForgetPassword(comment,id) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'article/comments/store');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url,headers: {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer ' + token,
    },
      body: jsonEncode(<String, String>{
        'title': comment,
        'name' : 'User Sky',
        'article_id':id
      }),);
    if (response.statusCode == 200) {
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  // get all Artical according id by api by use http package
  Future<void> GetArticlesDetails(artical_id) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'articles/'+artical_id);
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  // get all Artical according Categroy id by api by use http package

  Future<void> GetArticlesByCategroy(categroy_id) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'artical/categroy/'+categroy_id);
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  // get all Artical according Tag id by api by use http package
  Future<void> GetArticlesByTag(tag_id) async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'artical/tag/'+tag_id);
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  // get all Setting by api by use http package
  Future<void> Setting() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    var url = Uri.parse(Constants.MainUrlApi+'settings');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }






}




