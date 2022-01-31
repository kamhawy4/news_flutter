import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news/modules/Comments/comments_screen.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/shared/remote/constants.dart';


class DetailsScreen extends StatefulWidget {

  Map artical_details;
  DetailsScreen(this.artical_details);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState(this.artical_details);
}

class _DetailsScreenState extends State<DetailsScreen> {
  Map artical_details;

  _DetailsScreenState(Map this.artical_details);


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
    builder: (context, state) {
      var cubit = NewsCubit.get(context);
      var words_lang = AppLocalizations.of(context)!;
      var date = DateTime.parse(artical_details['created_at']);
      return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      child: Image.network(Constants.MainUrlImage+artical_details['image'],fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 10,
                    child: Icon(Icons.favorite, color: Colors.white),
                  ),
                  Positioned(
                    top: 40,
                    right: 70,

                    child: InkWell(
                        onTap: () {

                        },child: Icon(Icons.share, color: Colors.white)),
                  ),
                  Positioned(
                    top: 40,
                    left: 10,
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white)),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    child: Text(DateFormat.yMMMd().format(date),
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.comment, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          '27',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, top: 2.6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.visibility, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            '260',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      VerticalDivider(
                        thickness: 4,
                        width: 20,
                        color: Colors.amberAccent,
                      ),
                      Expanded(
                        child: Text(
                          artical_details['title'],
                          style:
                          Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
                child: Container(
                  child: Text(
                    artical_details['description'],
                    style: TextStyle(height: 2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, bottom: 30),
                child: ElevatedButton(
                  child: Text(words_lang.see_comments),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    onPrimary: Colors.white,
                    textStyle: Theme.of(context).textTheme.bodyText1,
                  ),
                  onPressed: () {
                    navigateTo(context, CommentsScreen(artical_details['id']));
                  },
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: Text(
                    words_lang.related_news,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              articalBuilder(context,'recent')
            ],
          ),
        ),
          bottomNavigationBar: NavigationBarBottom('internalScreen')
      );
    },
    );
  }
}
