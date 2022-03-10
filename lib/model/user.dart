class UserModel {
  String? name;
  String? email;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  String? id;
  bool? isAdmin;

  UserModel({
    this.bio,
    this.cover,
    this.image,
    this.email,
    this.id,
    this.name,
    this.isAdmin,
    this.phone,
  });

  UserModel.fromjson(Map<String, dynamic>? json) {
    id = json!['id'];
    email = json['email'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
    name = json['name'];
    phone = json['phone'];
    isAdmin = json['isAdmin'];
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'bio': bio,
      'image': image,
      'cover': cover,
      'phone': phone,
      'isAdmin': isAdmin,
      'id': id,
      'name': name,
    };
  }
}
