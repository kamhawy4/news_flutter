
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/layout/news_layout.dart';
import 'package:news/shared/components/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/shared/cubit/cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var words_lang = AppLocalizations.of(context)!;
    return
      Scaffold(
        body:
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Stack(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20,top: 20),
                        child: Text(
                          words_lang.forget_password,
                          style: Theme.of(context).textTheme.bodyText1
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color:Colors.amber,
                  ),
                  height: 300,
                  width: double.infinity,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  height: 300,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 4, right: 4,top: 60),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: NewsCubit.get(context).isDark ?  Colors.black54 : Colors.white70,
                    ),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(words_lang.forget_password,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 0,
                  top:300,
                  child: Align(
                    alignment: Alignment.center,
                    child: FloatingActionButton.large(
                      backgroundColor: Colors.amber,
                      onPressed: () {
                        navigateTo(context, NewsLayout());
                        // Validate returns true if the form is valid, or false otherwise.
                        // if (_formKey.currentState!.validate()) {
                        //   // If the form is valid, display a snackbar. In the real world,
                        //   // you'd often call a server or save the information in a database.
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(
                        //     const SnackBar(
                        //         content: Text('Processing Data')),
                        //   );
                        // }
                      },
                      child: Icon( Icons.arrow_forward),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(words_lang.have_account,
                        style: Theme.of(context).textTheme.bodyText1)),
                Container(
                    margin: EdgeInsets.only(top: 15),
                    child: TextButton(
                      style: ButtonStyle(
                      ),
                      onPressed: () {
                        navigateTo(context, NewsLayout());
                      },
                      child: Text(words_lang.sign_in,
                          style:Theme.of(context).textTheme.bodyText1),
                    )),
              ],
            ),
          ],
        ),
      );
  }
}
