import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_demo/Utils/size_utils.dart';
import 'package:news_demo/theme/app_color.dart';

import 'home_page_controller.dart';

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
          padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
          child: Stack(
            children: [
              Column(
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
                          image: NetworkImage(_homePageController
                                  .articleData.value.urlToImage ??
                              ""),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _homePageController.articleData.value.description ??
                              "",
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
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: SizeUtils.horizontalBlockSize * 5,
                top: SizeUtils.verticalBlockSize * 15,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white24,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(2, 2),
                            blurRadius: 40,
                            color: Colors.white,
                          )
                        ],
                        border: Border.all(color: Colors.white24)),
                    child: const Icon(
                      Icons.close,
                      size: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
