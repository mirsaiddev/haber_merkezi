import 'dart:convert';

class NewModel {
  final int categoryId;
  final String category;
  final String title;
  final String description;
  final String image;
  final String url;
  final String date;
  final String site;
  NewModel({
    required this.categoryId,
    required this.category,
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.date,
    required this.site,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'categoryId': categoryId});
    result.addAll({'category': category});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'image': image});
    result.addAll({'url': url});
    result.addAll({'date': date});
    result.addAll({'site': site});

    return result;
  }

  factory NewModel.fromMap(Map<String, dynamic> map) {
    return NewModel(
      categoryId: int.parse(map['kategoriID']),
      category: map['Kategori'] ?? '',
      title: map['Baslik'] ?? '',
      description: map['Aciklama'] ?? '',
      image: map['Resim'] ?? '',
      url: map['Link'] ?? '',
      date: (map['Tarih']),
      site: map['Site'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NewModel.fromJson(String source) => NewModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewModel(categoryId: $categoryId, category: $category, title: $title, description: $description, image: $image, url: $url, date: $date, site: $site)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewModel &&
        other.categoryId == categoryId &&
        other.category == category &&
        other.title == title &&
        other.description == description &&
        other.image == image &&
        other.url == url &&
        other.date == date &&
        other.site == site;
  }

  @override
  int get hashCode {
    return categoryId.hashCode ^ category.hashCode ^ title.hashCode ^ description.hashCode ^ image.hashCode ^ url.hashCode ^ date.hashCode ^ site.hashCode;
  }
}
