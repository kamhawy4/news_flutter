
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/layout/news_layout.dart';
import 'package:news/modules/Auth/login_screen.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cubit = NewsCubit.get(context);
    return
      Scaffold(
        body:
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Stack(
              children: [
                CustemBar(context,'Edit Account'),
                Container(
                  padding: EdgeInsets.all(20),
                  height: 500,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 4, right: 4,top: 60),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: HexColor("#ffffff"),
                    ),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 15,left: 30),
                            child: Text('Edit Account',
                                style:Theme.of(context).textTheme.bodyText1)),
                        Divider(
                          height: 25,
                          thickness: 2,
                          endIndent: width / 3.8,
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
                                  onChanged: (text) {
                                    _name.text =  text;
                                  },
                                  initialValue: _name.text == cubit.name || _name.text.isEmpty ? _name.text = cubit.name : _name.text,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'Name',
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
                                  onChanged: (text) {
                                    _email.text = text;
                                  },
                                  initialValue: _email.text == cubit.email || _email.text.isEmpty ? _email.text = cubit.email : _email.text,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'Email',
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
                                  onChanged: (text) {
                                    _phone.text = text;
                                  },
                                  initialValue: _phone.text == cubit.phone || _phone.text.isEmpty ? _phone.text = cubit.phone : _phone.text,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.phone),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'Phone',
                                  ),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Phone';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: TextFormField(
                                  onChanged: (text) {
                                    _password.text = text;
                                  },
                                  initialValue: _password.text.isEmpty ? '' : _password.text,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.password),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'Password',
                                  ),
                                  // The validator receives the text that the user has entered.

                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(25),
              child: FloatingActionButton.extended(
                elevation: 0.0,
                backgroundColor: Colors.amber,
                onPressed: () {
                  //Validate returns true if the form is valid, or false otherwise.
                  if(_formKey.currentState!.validate()){
                    cubit.Edituser(context,_name,_email,_phone,_password);
                    FocusManager.instance.primaryFocus?.unfocus();
                    //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')));
                  }
                },
                label: Text('Edit Account'),
              ),
            ),

          ],
        ),
          bottomNavigationBar: NavigationBarBottom('internalScreen')
      );
  }
}
