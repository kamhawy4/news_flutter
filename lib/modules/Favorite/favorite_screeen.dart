import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        var words_lang = AppLocalizations.of(context)!;
        return ListView(
          physics: BouncingScrollPhysics(),
          children: [
            CustemBar(context,words_lang.favorite),
            articalBuilderFavorite(context,'favorite')
          ],
        );
  }
}
