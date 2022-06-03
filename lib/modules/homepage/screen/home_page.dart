import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_demo/Utils/size_utils.dart';
import 'package:news_demo/modules/homepage/screen/news_detail_screen.dart';

import '../../../theme/app_color.dart';
import '../controller/home_page_controller.dart';

class HomePageScreen extends StatefulWidget {
  static const routeName = '/homePage_screen';

  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final HomePageController _homePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey.withOpacity(0.5)),
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.greyColors,
                ),
              ),
              alignment: Alignment.center,
              child: TextFormField(
                controller: _homePageController.searchController,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (String value) {
                  if (_homePageController.searchController.text.isNotEmpty) {
                    _homePageController.getNewsData(_homePageController.searchController.text);

                    _homePageController.newsDataModel.refresh();
                  } else {
                    _homePageController.getAllNewsData();
                    _homePageController.newsDataModel.refresh();
                  }
                },
                cursorColor: AppColor.appColors,
                style: GoogleFonts.signika(
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search News ",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Obx(
            () => _homePageController.isLoading.value
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      primary: true,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            _homePageController.articleData.value = _homePageController.newsDataModel.value.articles![i];
                            Get.toNamed(
                              DetailedNewsScreen.routeName,
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 2, vertical: SizeUtils.verticalBlockSize * 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Image.network(
                                        _homePageController.newsDataModel.value.articles?[i].urlToImage ?? "",
                                        fit: BoxFit.cover,
                                        height: SizeUtils.verticalBlockSize * 20,
                                        width: double.infinity,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Container(
                                              height: SizeUtils.verticalBlockSize * 20,
                                              color: Colors.grey[300],
                                              child: const Center(child: CircularProgressIndicator()));
                                        },
                                        errorBuilder: (context, error, stackTrace) => Center(
                                          child: Container(
                                              height: SizeUtils.verticalBlockSize * 20,
                                              width: double.infinity,
                                              color: Colors.grey[300],
                                              child: const Center(child: Text(" No Image!!!"))),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: IconButton(
                                          onPressed: () async {
                                            if (_homePageController.newsDataModel.value.articles?[i].isLike == true) {
                                              _homePageController.saveNewsDataModel.value.articles!.removeAt(i);
                                              _homePageController.saveNewsDataModel.refresh();
                                              await _homePageController.unLikeAndSave(_homePageController.saveNewsDataModel.value.articles!);
                                              _homePageController.newsDataModel.value.articles?[i].isLike = false;
                                            } else {
                                              await _homePageController.setLike(_homePageController.newsDataModel.value.articles![i]);
                                              _homePageController.newsDataModel.value.articles?[i].isLike = true;
                                            }
                                            _homePageController.newsDataModel.refresh();
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: (_homePageController.newsDataModel.value.articles?[i].isLike ?? false)
                                                ? Colors.red
                                                : Colors.grey[300],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeUtils.verticalBlockSize * 1,
                                  ),
                                  Text(
                                    _homePageController.newsDataModel.value.articles?[i].title ?? "",
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: SizeUtils.verticalBlockSize * 1.5,
                                  ),
                                  Text(
                                    _homePageController.newsDataModel.value.articles?[i].content ?? "",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: _homePageController.newsDataModel.value.articles?.length ?? 0,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
