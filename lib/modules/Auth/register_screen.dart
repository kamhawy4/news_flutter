
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/shared/components/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _password_confirmation = TextEditingController();
  final TextEditingController _phone = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cubit = NewsCubit.get(context);
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
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20,top: 10,bottom: 10),
                            child: Text(
                              words_lang.welcome,
                              style: Theme.of(context).textTheme.bodyText1
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 3,top: 10,bottom: 10),
                            child: Text(
                              'News App',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          words_lang.sign_continue,
                          style: Theme.of(context).textTheme.bodyText1
                        ),
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
                  height: 800,
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
                            child: Text(words_lang.sign_up,
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
                                  controller: _name,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: words_lang.name,
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
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
                                  controller: _phone,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.phone),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: words_lang.phone,
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your phone';
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
                                  obscureText: true,
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
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: TextFormField(
                                  controller: _password_confirmation,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.password),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: words_lang.password_confirmation,
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password confirmation';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 15,right: 20,left: 20),
                                  child: Text(words_lang.creating_an_account,
                                      style: Theme.of(context).textTheme.bodyText1)),
                              Container(
                                  child: TextButton(
                                    style: ButtonStyle(
                                    ),
                                    onPressed: () {
                                      navigateTo(context, LoginScreen());
                                    },
                                    child: Text(words_lang.term_condtions,
                                        style:Theme.of(context).textTheme.bodyText1),
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
                  top:800,
                  child: Align(
                    alignment: Alignment.center,
                    child: FloatingActionButton.large(
                      elevation: 0.0,
                      backgroundColor: Colors.amber,
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if(_formKey.currentState!.validate()){
                          cubit.SignUp(context,_name,_email,_phone,_password,_password_confirmation);
                          FocusManager.instance.primaryFocus?.unfocus();
                          _name.text = '';
                          _email.text = '';
                          _phone.text = '';
                          _password.text = '';
                          _password_confirmation.text = '';
                          //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')));
                        }
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
                        navigateTo(context, LoginScreen());
                      },
                      child: Text(words_lang.sign_in  ,
                          style:Theme.of(context).textTheme.bodyText1),
                    )),
              ],
            ),
          ],
        ),
      );
  }
}
