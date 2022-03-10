class ProductModel {
  String? title;
  String? image;
  dynamic price;
  dynamic id;
  String? category;
  String? description;
  Rating? rating;

  ProductModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }
}

class Rating {
  dynamic rate;
  dynamic count;
  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    count = json['count'];
  }
}
