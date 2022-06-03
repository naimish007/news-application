import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_demo/Utils/size_utils.dart';
import 'package:news_demo/theme/app_color.dart';

import '../controller/home_page_controller.dart';

class DetailedNewsScreen extends StatelessWidget {
  static const routeName = '/detailed_news_screen';
  final HomePageController _homePageController = Get.find();
  DetailedNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5, vertical: SizeUtils.verticalBlockSize * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _homePageController.articleData.value.title ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeUtils.fSize_18(),
                  color: AppColor.blackColor,
                ),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 3,
              ),
              Container(
                height: SizeUtils.verticalBlockSize * 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(_homePageController.articleData.value.urlToImage ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: SizeUtils.verticalBlockSize * 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _homePageController.articleData.value.description ?? "",
                      style: TextStyle(
                        fontSize: SizeUtils.fSize_15(),
                        color: AppColor.blackColor.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 2,
                    ),
                    Text(
                      _homePageController.articleData.value.content ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: SizeUtils.fSize_15(),
                        color: AppColor.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
