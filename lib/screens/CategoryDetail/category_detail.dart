import 'package:flutter/material.dart';
import 'package:news_app_v1/models/new_model.dart';
import 'package:news_app_v1/screens/Home/home_screen.dart';
import 'package:news_app_v1/services/api_service.dart';
import 'package:news_app_v1/theme/colors.dart';

class CategoryDetail extends StatefulWidget {
  const CategoryDetail({Key? key, required this.categoryName, required this.categoryId}) : super(key: key);

  final String categoryName;
  final int categoryId;

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  int page = 0;
  bool loading = false;
  ScrollController scrollController = ScrollController();
  List<NewModel> news = [];

  void listener() {
    scrollController.addListener(() {
      if (scrollController.hasClients) {
        if (scrollController.offset >= scrollController.position.maxScrollExtent - 100) {
          Future.delayed(Duration.zero).then((value) => getNews());
        }
      }
    });
  }

  Future<void> getNews() async {
    if (loading) {
      return;
    }
    loading = true;
    List<NewModel> _news = await ApiService().getCategoryNews(categoryId: widget.categoryId, page: page);
    news.addAll(_news);
    page++;
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getNews();
    listener();
  }

  @override
  Widget build(BuildContext context) {
    print(news.length);
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    BackButton(),
                    Text(
                      widget.categoryName,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: MyColors.greyDark),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    return NewTile(
                      newModel: news[index],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
