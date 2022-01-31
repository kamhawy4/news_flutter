import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/shared/components/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CommentsScreen extends StatefulWidget {
  int id;

  CommentsScreen(this.id);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _validate = false;

  bool validateTextField(String commentInput) {
    if (commentInput.isEmpty) {
      setState(() {
        _validate = true;
      });
      return false;
    }
    setState(() {
      _validate = false;
    });
    return true;
  }

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
        () => 'Data Loaded',
  );


  @override
  Widget build(BuildContext context) {
    var words_lang = AppLocalizations.of(context)!;
    var cubit = NewsCubit.get(context);
    NewsCubit.get(context).isLoading = true;
    cubit.allComments = null;
    // cubit.allComments;
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustemBar(context,words_lang.comments),
              Expanded(
                child: FutureBuilder<Object>(
                    future: _calculation,
                    builder: (BuildContext context, snapshot) {
                      cubit.ArticlComments(this.widget.id.toString());
                      var comments =  cubit.allComments;
                      return ConditionalBuilder(condition:
                          cubit.allComments != null && cubit.allComments.length > 0,
                          builder: (context) =>  ListView.builder(
                        itemCount: comments['response'].length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var date = DateTime.parse(comments['response'][index]['created_at']);
                          return Column(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: CircleAvatar(
                                          radius: 30.0,
                                          backgroundImage:
                                          NetworkImage(
                                              "https://i.pravatar.cc/300"),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 5, bottom: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    comments['response'][index]['name'],
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight
                                                            .bold
                                                    ),),
                                                  SizedBox(width: 5),
                                                  Text(' - ' +
                                                      DateFormat.yMMMd()
                                                          .format(date),
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .bodyText1),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                comments['response'][index]['title'],
                                                style: TextStyle(
                                                    height: 1.6
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 20,
                                    thickness: 0.6,
                                    indent: 0,
                                    endIndent: 0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),fallback: (context) {
                        return Loading();
                      });
                    }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: words_lang.write_comment,
                    errorText: _validate ? 'Comment Can\'t Be Empty' : null,
                    suffixIcon: IconButton(
                      onPressed: () => {
                        setState(() {
                          FocusManager.instance.primaryFocus?.unfocus();
                          validateTextField(_controller.text);
                          cubit.SendArticlComments(_controller.text,this.widget.id.toString());
                          _controller.text = '';
                        }),
                      },
                      icon: Icon(Icons.send,color: Colors.amber,),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: NavigationBarBottom('internalScreen')
    );
  }
}
