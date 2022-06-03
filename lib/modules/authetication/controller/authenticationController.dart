import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Tabbar/TabbarScreen.dart';
import '../../homepage/homePage.dart';
import '../loginScreen.dart';

class AuthenticationController extends GetxController {
  String? token = "";
  RxString userName = "".obs;
  RxBool isLoading = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  Future<void> handleGetContact(GoogleSignInAccount user) async {
    token = (await user.authentication).idToken;
    print("token :- $token");
  }

  Future<void> signInWithGoogle() async {
    log("_googleSignIn.currentUser.displayName.isNotEmpty==${_googleSignIn.currentUser?.displayName.toString()}");

    var result = await _googleSignIn.signIn();
    await handleGetContact(_googleSignIn.currentUser!);
    log('result :${result.toString()}');
    if (_googleSignIn.currentUser?.id.isNotEmpty ?? false) {
      userName.value = _googleSignIn.currentUser?.displayName.toString() ?? "";
      Get.offAllNamed(TabBarScreen.routeName);
    }
  }

  Future<void> logOut() async {
    try {
      isLoading.value = true;

      await _googleSignIn.signOut();

      Get.offAndToNamed(LoginScreen.routeName);

      return;
    } catch (e, st) {
      // AppException.showException(e, st);
    } finally {
      isLoading.value = false;
    }
  }
}
