import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/layout/news_layout.dart';
import 'package:news/modules/Home/home_screen.dart';
import 'package:news/modules/Auth/register_screen.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';

import 'forget_password_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cubit = NewsCubit.get(context);
    var words_lang = AppLocalizations.of(context)!;
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(words_lang.welcome,
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(words_lang.sign_continue,
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                height: 300,
                width: double.infinity,
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.only(left: 4, right: 4, top: 100),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: NewsCubit.get(context).isDark ?  Colors.black54 : Colors.white70,
                  ),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(words_lang.sign_in,
                              style: Theme.of(context).textTheme.bodyText1)),
                      Divider(
                        height: 25,
                        thickness: 2,
                        endIndent: width / 3,
                        indent: width / 3,
                        color: HexColor("#F0AB00"),
                      ),
                      SizedBox(height: 30),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: _email,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: words_lang.email,
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: _password,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.password),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: words_lang.password,
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            // Container(
                            //     child: InkWell(
                            //   onTap: () {
                            //     // navigateTo(context, ForgetPasswordScreen());
                            //   },
                            //   child: Text(words_lang.forget_your_password,
                            //       style: Theme.of(context).textTheme.bodyText1),
                            // )),
                            Container(
                                child: TextButton(
                              style: ButtonStyle(),
                              onPressed: ()  {
                                navigateTo(context, SignUpScreen());
                              },
                              child: Text(words_lang.sign_up,
                                  style: Theme.of(context).textTheme.bodyText1),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                bottom: 0,
                top: 500,
                child: Align(
                  alignment: Alignment.center,
                  child: FloatingActionButton.large(
                    backgroundColor: Colors.amber,
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        cubit.SignIn(context,_email,_password);
                        FocusManager.instance.primaryFocus?.unfocus();
                        // _email.text = '';
                        // _password.text = '';
                        //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')));
                      }

                    },
                    child: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
