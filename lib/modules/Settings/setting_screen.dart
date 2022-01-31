import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/layout/news_layout.dart';
import 'package:news/modules/Languages/languages_screen.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/shared/locale/cache_helper.dart';
import '../Auth/login_screen.dart';
import 'edit_account_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key, required this.value, required this.onChanged,}) : super(key: key);
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = CacheHelper.getBoolean(key: 'isDark');
  @override
  Widget build(BuildContext context) {
    var words_lang = AppLocalizations.of(context)!;
    var cubit = NewsCubit.get(context);

    return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              CustemBar(context,words_lang.setting),
              Divider(
                indent: 0,
                endIndent: 0,
                height: 1,
                color: Colors.amber,
              ),
              Container(
                height: 100,
                color:  NewsCubit.get(context).isDark  ? HexColor('4b5154') : Colors.white,
                alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                        NetworkImage("https://i.pravatar.cc/300"),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(cubit.name,style: Theme.of(context).textTheme.bodyText1),
                           SizedBox(height:10),
                           Text(cubit.email,style: Theme.of(context).textTheme.bodyText1)
                         ],
                      ),
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width / 1,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:  NewsCubit.get(context).isDark  ? HexColor('4b5154') : Colors.white
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Expanded(
                             child: Text(words_lang.dark_mode ,style:Theme.of(context).textTheme.bodyText1,),
                           ),
                           Switch(
                             activeTrackColor:Colors.amber,
                             activeColor:Colors.amber,
                             autofocus:true,
                             value: isSwitched,
                             onChanged: (value) {
                               NewsCubit.get(context).changeAppMode();
                               setState(() {
                                 isSwitched = CacheHelper.getBoolean(key: 'isDark');
                               });
                             },
                           ),
                         ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5,left: 25,right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(words_lang.notification,style:Theme.of(context).textTheme.bodyText1,),
                          Switch(
                            value: widget.value,
                            onChanged: (bool newValue) {
                              widget.onChanged(newValue);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,left: 25),
                  child: Text(
                    words_lang.account,
                    style:Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: NewsCubit.get(context).isDark ? HexColor('4b5154') : Colors.white
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 25,right: 25),
                      child: InkWell(
                        onTap: () {
                          navigateTo(
                              context, EditAccountScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(words_lang.edit_account ,style:Theme.of(context).textTheme.bodyText1),
                            Icon(Icons.arrow_forward_ios, color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 25,right: 25,bottom: 20),

                      child: InkWell(
                        onTap: () {
                          navigateTo(
                              context, Languages());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Text(words_lang.language,style:Theme.of(context).textTheme.bodyText1,
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber
                ),
                  margin: EdgeInsets.all( 20),
                  child: InkWell(
                    onTap: () {
                      CacheHelper.prefs.remove('token');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext ctx) => LoginScreen()));
                    },
                    child: Text(words_lang.logout,
                        style:Theme.of(context).textTheme.bodyText1),
                  )),
            ],
          );
  }
}
