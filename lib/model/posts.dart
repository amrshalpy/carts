class PostModel {
  String? name;
  String? imagePost;
  String? image;
  String? text;
  String? id;
  String? date;
  PostModel({
    this.date,
    this.text,
    this.image,
    this.imagePost,
    this.id,
    this.name,
  });

  PostModel.fromjson(Map<String, dynamic> json) {
    imagePost = json['imagePost'];
    date = json['date'];
    image = json['image'];
    text = json['text'];
    name = json['name'];
    id = json['id'];
  }
  Map<String, dynamic> toMap() {
    return {
      'imagePost': imagePost,
      'date': date,
      'image': image,
      'text': text,
      'id': id,
      'name': name,
    };
  }
}
