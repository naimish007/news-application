import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_demo/helpers/shared_preference.dart';

import '../../Tabbar/tabbar_screen.dart';
import '../screen/login_screen.dart';

class AuthenticationController extends GetxController {
  String? token = "";
  RxString userName = "".obs;
  RxString userid = "".obs;
  RxBool isLoading = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<void> handleGetContact(GoogleSignInAccount user) async {
    token = (await user.authentication).idToken;
  }

  Future<void> signInWithGoogle() async {
    var result = await _googleSignIn.signIn();
    await handleGetContact(_googleSignIn.currentUser!);
    userid.value = _googleSignIn.currentUser?.id ?? '';
    if (_googleSignIn.currentUser?.id.isNotEmpty ?? false) {
      userName.value = _googleSignIn.currentUser?.displayName.toString() ?? "";
      AppSharedPreference.setUserName(userName.value);
      Get.offAllNamed(TabBarScreen.routeName);
    }
  }

  Future<void> checkLogin() async {
    userName.value = AppSharedPreference.userName.toString();
    if (AppSharedPreference.userName != null && AppSharedPreference.userName != '') {
      Get.offAllNamed(TabBarScreen.routeName);
    } else {
      Get.offAllNamed(LoginScreen.routeName);
    }
  }

  Future<void> logOut() async {
    try {
      isLoading.value = true;
      await _googleSignIn.signOut();
      AppSharedPreference.clear();
      Get.offAndToNamed(LoginScreen.routeName);

      return;
    } catch (e) {
      log("error==$e");
    } finally {
      isLoading.value = false;
    }
  }
}
