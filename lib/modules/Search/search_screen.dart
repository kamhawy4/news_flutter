
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/shared/components/components.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/shared/cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var  wordsLang = AppLocalizations.of(context)!;
    var cubit = NewsCubit.get(context);
   return ListView(
     physics: BouncingScrollPhysics(),
        children: [
          CustemBar(context,wordsLang.search),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              onChanged: (text) {
                cubit.GetArticlesSearch(context,text);
              },
              validator : (value){
                if (value!.isEmpty) {
                  return 'search must not be empty';
                }
                return null;
              },
              decoration:  InputDecoration(
                labelStyle: Theme.of(context).textTheme.bodyText1,
                  border: UnderlineInputBorder(),
                  labelText:  wordsLang.search
              ),
            ),

          ),
          articalBuilderSeach(context,'search')
        ],
      );
  }
}
