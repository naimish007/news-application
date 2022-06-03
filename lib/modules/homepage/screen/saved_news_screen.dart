import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_demo/Utils/size_utils.dart';
import 'package:news_demo/modules/homepage/controller/home_page_controller.dart';

class SavedNewsScreen extends StatefulWidget {
  static const routeName = '/saved_News_screen';

  const SavedNewsScreen({Key? key}) : super(key: key);

  @override
  State<SavedNewsScreen> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  final HomePageController _homePageController = Get.find()..getSaveArticlesList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _homePageController.isLoadingSecond.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                primary: true,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 2, vertical: SizeUtils.verticalBlockSize * 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.network(
                                _homePageController.saveNewsDataModel.value.articles?[i].urlToImage ?? "",
                                fit: BoxFit.cover,
                                height: SizeUtils.verticalBlockSize * 20,
                                width: double.infinity,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                      height: SizeUtils.verticalBlockSize * 20,
                                      color: Colors.grey[300],
                                      child: const Center(child: CircularProgressIndicator()));
                                },
                                errorBuilder: (context, error, stackTrace) => const Center(
                                  child: Text(" No Image!!!"),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: IconButton(
                                  onPressed: () {
                                    _homePageController.saveNewsDataModel.value.articles!.removeAt(i);
                                    _homePageController.saveNewsDataModel.refresh();
                                    _homePageController.unLikeAndSave(_homePageController.saveNewsDataModel.value.articles!);
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1,
                          ),
                          Text(
                            _homePageController.saveNewsDataModel.value.articles?[i].title ?? "",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1.5,
                          ),
                          Text(
                            _homePageController.saveNewsDataModel.value.articles?[i].content ?? "",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: _homePageController.saveNewsDataModel.value.articles?.length ?? 0,
              ),
      ),
    );
  }
}
