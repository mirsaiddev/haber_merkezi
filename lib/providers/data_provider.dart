import 'package:flutter/material.dart';
import 'package:news_app_v1/models/new_model.dart';
import 'package:news_app_v1/services/api_service.dart';

class DataProvider extends ChangeNotifier {
  List<Map<String, dynamic>> categories = [];
  bool categoriesGet = false;
  Map<int, List<NewModel>> news = {};
  List<Map> initialNews = [];

  Future<void> getCategories({bool force = false}) async {
    if (!force && categoriesGet) {
      return;
    }
    List<Map<String, dynamic>> _categories = await ApiService().getCategories();
    categories.clear();
    categories.addAll(_categories);
    categoriesGet = true;
    notifyListeners();
  }

  Future<void> getInitialNews() async {
    List<NewModel> news = await ApiService().getInitialNews();
    initialNews.clear();
    news.forEach((newModel) {
      if (initialNews.any((element) => element['category_id'] == newModel.categoryId)) {
        initialNews[initialNews.indexWhere((element) => element['category_id'] == newModel.categoryId)]['news'].add(newModel);
      } else {
        String categoryName = categories.firstWhere((element) => element['id'] == newModel.categoryId.toString())['Baslik'];
        initialNews.add({
          'category_name': categoryName,
          'category_id': newModel.categoryId,
          'news': [newModel]
        });
      }
    });
  }

  Future<void> getData() async {
    await getCategories();
    getInitialNews();
  }
}
