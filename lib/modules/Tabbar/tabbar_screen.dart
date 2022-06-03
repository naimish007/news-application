import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/size_utils.dart';
import '../../theme/app_color.dart';
import '../authentication/controller/authentication_controller.dart';
import 'controller/tab_bar_controller.dart';

class TabBarScreen extends StatelessWidget {
  static const routeName = '/tab_bar_screen';
  TabBarScreen({Key? key}) : super(key: key);
  final TabBarController tabBarScreenController = Get.find();
  final AuthenticationController _authenticationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome, ${_authenticationController.userName.value}",
          style: const TextStyle(color: AppColor.blackColor),
        ),
        actions: [
          GestureDetector(
            child: const Icon(Icons.logout),
            onTap: () async {
              await _authenticationController.logOut();
            },
          ),
        ],
      ),
      body: Obx(() => tabBarScreenController.page[tabBarScreenController.selectItem.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          showUnselectedLabels: true,
          selectedItemColor: Colors.green,
          unselectedLabelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: SizeUtils.fSize_12(),
          ),
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          currentIndex: tabBarScreenController.selectItem.value,
          onTap: (value) async {
            tabBarScreenController.selectItem.value = value;
          },
          selectedLabelStyle: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
            fontSize: SizeUtils.fSize_12(),
          ),
          items: [
            _tabBarItem(
              label: "HomePage",
              index: 0,
              selectedIcon: Icons.home_rounded,
            ),
            _tabBarItem(
              label: "Saved Items",
              index: 1,
              selectedIcon: Icons.save_sharp,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _tabBarItem({required int index, required IconData selectedIcon, required String label}) {
    return BottomNavigationBarItem(
      icon: Padding(padding: const EdgeInsets.only(bottom: 10), child: Icon(selectedIcon)),
      label: label,
    );
  }
}
