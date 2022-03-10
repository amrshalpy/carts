import 'dart:io';

import 'package:carts/compnement/compnement.dart';
import 'package:carts/compnement/const.dart';
import 'package:carts/compnement/constants.dart';
import 'package:carts/home_cubit/home_state.dart';
import 'package:carts/model/posts.dart';
import 'package:carts/model/user.dart';
import 'package:carts/moduels/activity_feed/activity_feed.dart';
import 'package:carts/moduels/chat/chat.dart';
import 'package:carts/moduels/feeds/feeds.dart';
import 'package:carts/moduels/posts/posts.dart';
import 'package:carts/moduels/setting/setting.dart';
import 'package:carts/style/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> screen = [
    Feeds(),
    ActivityFeed(),
    Posts(),
    Chat(),
    Setting(),
  ];

  List<Widget> title = [
    Row(
      children: [
        Text('Home'),
        Icon(
          Icons.home,
          color: mainColor,
        ),
      ],
    ),
    Row(
      children: [
        Text('ActivityFeed'),
        Icon(
          Icons.notification_important,
          color: mainColor,
        ),
      ],
    ),
    Row(
      children: [
        Text('Posts'),
        Icon(
          Icons.post_add_outlined,
          color: mainColor,
        ),
      ],
    ),
    Row(
      children: [
        Text('Chat'),
        Icon(
          Icons.chat,
          color: mainColor,
        ),
      ],
    ),
    Row(
      children: [
        Text('Setting'),
        Icon(
          Icons.settings,
          color: mainColor,
        ),
      ],
    ),
  ];

  int currentIndex = 0;

  void changeCurrentIndex(int index, context) {
    currentIndex = index;
    if (index == 2) {
      nextPage(context: context, page: Posts());
    }
    emit(ChangeCurrentIndex());
  }

  bool isAdmin = false;
  void getAdmin() {
    emit(GetAdminLoading());
    FirebaseFirestore.instance.collection(kUser).doc(uid).get().then((value) {
      value.data()!['isAdmin'] == true ? isAdmin = true : false;
      emit(GetAdminSucsses());
    }).catchError((er) {
      emit(GetAdminError());

      print(er.toString());
    });
  }

  void getUsers() {
    emit(GetUsersLoading());
    FirebaseFirestore.instance
        .collection(kUser)
        .doc(uid)
        .snapshots()
        .listen((value) {
      userModel = null;
      userModel = UserModel.fromjson(value.data());
      print('user name is ${userModel!.name}');
      emit(GetUsersSucsses());
    });
  }

  var picker = ImagePicker();

  File? imagePost;
  void uploadImagePost() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePost = File(image.path);
      emit(SaveImagePostSucsses());
    } else {
      emit(SaveImagePostError());

      print('no image');
    }
  }

  void storageImagePost({
    String? text,
    String? date,
  }) {
    emit(UploadImagePostLoading());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/ ${Uri.file(imagePost!.path).pathSegments.last}')
        .putFile(imagePost!)
        .then((value) {
      value.ref.getDownloadURL().then((val) {
        savePostData(date: date, imagePost: val, text: text);
        emit(UploadImagePostSucsses());
      }).catchError((er) {
        emit(UploadImagePostError());

        print(er.toString());
      });
    }).catchError((er) {
      emit(UploadImagePostError());

      print(er.toString());
    });
  }

  UserModel? userModel;

  void savePostData({
    String? text,
    String? date,
    String? imagePost = '',
  }) {
    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      id: userModel!.id,
      text: text,
      date: date,
      imagePost: imagePost ?? '',
    );
    emit(AddPostLoading());

    FirebaseFirestore.instance
        .collection(kPosts)
        .doc()
        .set(model.toMap())
        .then((value) {
      emit(AddPostSucsses());
    }).catchError((er) {
      emit(AddPostError());

      print(er.toString());
    });
  }

  File? imageProfile;
  void uploadImageProfile() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageProfile = File(image.path);
      emit(SaveImageProfileSucsses());
    } else {
      emit(SaveImageProfileError());

      print('no image');
    }
  }

  PostModel? postModel;
  void StorageImageProfile({
    String? phone,
    String? bio,
    String? name,
  }) {
    emit(UploadImageProfileLoading());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/ ${Uri.file(imageProfile!.path).pathSegments.last}')
        .putFile(imageProfile!)
        .then((value) {
      value.ref.getDownloadURL().then((val) {
        saveUserData(image: val, bio: bio, phone: phone, name: name);
        emit(UploadImageProfileSucsses());
      }).catchError((er) {
        emit(UploadImageProfileError());

        print(er.toString());
      });
    }).catchError((er) {
      emit(UploadImageProfileError());

      print(er.toString());
    });
  }

  File? imageCover;
  void uploadImageCover() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageCover = File(image.path);
      emit(SaveImageCoverSucsses());
    } else {
      emit(SaveImageCoverError());

      print('no image');
    }
  }

  void StorageImageCover({
    String? phone,
    String? bio,
    String? name,
  }) {
    emit(UploadImageCoverLoading());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/ ${Uri.file(imageCover!.path).pathSegments.last}')
        .putFile(imageCover!)
        .then((value) {
      value.ref.getDownloadURL().then((val) {
        saveUserData(cover: val, bio: bio, phone: phone, name: name);
        emit(UploadImageCoverSucsses());
      }).catchError((er) {
        emit(UploadImageCoverError());

        print(er.toString());
      });
    }).catchError((er) {
      emit(UploadImageCoverError());

      print(er.toString());
    });
  }

  void saveUserData({
    String? bio,
    String? phone,
    String? name,
    String? image = '',
    String? cover = '',
  }) {
    UserModel model = UserModel(
      bio: bio,
      cover: cover ?? '',
      phone: phone,
      image: image ?? '',
      name: name,
    );
    emit(UpdateUsersLoading());

    FirebaseFirestore.instance
        .collection(kUser)
        .doc(uid)
        .update(model.toMap())
        .then((value) {
      emit(UpdateUsersSucsses());
    }).catchError((er) {
      emit(UpdateUsersError());

      print(er.toString());
    });
  }

  void updatePost({
    String? date,
    String? txt,
    String? image,
    String? id,
  }) {
    PostModel model = PostModel(
      date: date,
      imagePost: image,
      text: txt,
    );
    emit(UpdatePostsLoading());

    FirebaseFirestore.instance
        .collection(kPosts)
        .doc(id)
        .update(model.toMap())
        .then((value) {
      emit(UpdatePostsSucsses());
    }).catchError((er) {
      emit(UpdatePostsError());

      print(er.toString());
    });
  }

  void deletePost(id) {
    emit(DeletePostLoading());

    FirebaseFirestore.instance
        .collection(kPosts)
        .doc(id)
        .delete()
        .then((value) {
      emit(DeletePostSucsses());
    }).catchError((er) {
      emit(DeletePostError());

      print(er.toString());
    });
  }

  void removeImagePost() {
    imagePost = null;
    emit(RemoveImagePostSucsses());
  }

  List<PostModel> posts = [];
  void getPosts() {
    emit(GetPostsLoading());
    FirebaseFirestore.instance.collection(kPosts).snapshots().listen((event) {
      posts = [];
      event.docs.forEach((element) {
        posts.add(PostModel.fromjson(element.data()));
        emit(GetPostsSucsses());
      });
    });
  }
}
