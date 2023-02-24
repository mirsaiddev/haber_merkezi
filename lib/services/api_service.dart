import 'package:dio/dio.dart';
import 'package:news_app_v1/models/new_model.dart';

class ApiService {
  static final ApiService _singleton = ApiService._internal();

  factory ApiService() {
    return _singleton;
  }

  ApiService._internal() {
    dio.options.baseUrl = 'https://api.haberintr.com';
  }

  Dio dio = Dio();

  Future<List<Map<String, dynamic>>> getCategories() async {
    Response response = await dio.get('/Api.php?neresi=kategoriler&key=58F55840652105C34D99CF00069C62D9');
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> categories = response.data['kategoriler'].map<Map<String, dynamic>>((e) => e as Map<String, dynamic>).toList();
      return categories;
    } else {
      return [];
    }
  }

  Future<List<NewModel>> getInitialNews() async {
    Response response = await dio.get('/Api.php?neresi=haberler&key=58F55840652105C34D99CF00069C62D9');
    if (response.statusCode == 200) {
      List<NewModel> news = response.data['haberler'].map<NewModel>((e) => NewModel.fromMap(e)).toList();
      return news;
    } else {
      return [];
    }
  }

  Future<List<NewModel>> getCategoryNews({required int categoryId, int page = 1}) async {
    String url = '/Api.php?neresi=haberler&key=58F55840652105C34D99CF00069C62D9&limit=10&kategori=$categoryId&baslangic=${page * 10}';
    print('url: $url');
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      List<NewModel> news = response.data['haberler'].map<NewModel>((e) => NewModel.fromMap(e)).toList();
      return news;
    } else {
      return [];
    }
  }
}
