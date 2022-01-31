import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/shared/components/components.dart';

class Languages extends StatelessWidget {
  const Languages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: changeLang(context),
          bottomNavigationBar: NavigationBarBottom('internalScreen')
      ),
    );
  }
}
