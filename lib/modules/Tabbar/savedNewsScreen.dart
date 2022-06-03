import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_color.dart';

class SavedNewsScreen extends StatelessWidget {
  static const routeName = '/saved_News_screen';
  const SavedNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColor.backgroundColor,
        child: Text("tab2"),
      ),
    );
  }
}
