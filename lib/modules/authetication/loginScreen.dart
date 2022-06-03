import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_demo/Utils/size_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_color.dart';
import 'package:get/get.dart';
import 'controller/authenticationController.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login_screen';
  LoginScreen({Key? key}) : super(key: key);
  final AuthenticationController _authenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          await _authenticationController.signInWithGoogle();
        },
        child: Center(
          child: Container(
            height: SizeUtils.verticalBlockSize * 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.greyColors,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.blueColors),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5),
            margin: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/google.png",
                    height: 24,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Login With Google",
                        style: GoogleFonts.signika(
                          color: AppColor.blackColor,
                          fontSize: SizeUtils.horizontalBlockSize * 6,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
