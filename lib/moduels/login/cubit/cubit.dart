import 'package:bloc/bloc.dart';
import 'package:carts/compnement/const.dart';
import 'package:carts/compnement/constants.dart';
import 'package:carts/model/user.dart';
import 'package:carts/moduels/login/cubit/state.dart';
import 'package:carts/share/local/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  void loginWithEmail({
    required email,
    required password,
  }) {
    emit(LoginWithEmailLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      saveDataInCacheHelper(value.user!.uid);

      emit(LoginWithEmailSucsses());
    }).catchError((er) {
      emit(LoginWithEmailError());

      print(er.toString());
    });
  }

  void createNewUserWithEmail({
    required email,
    required password,
    required name,
    required phone,
  }) {
    emit(CreateUserWithEmailLoading());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(CreateUserWithEmailSucsses());

      saveUserData(
        value,
        email: email,
        name: name,
        phone: phone,
        isAdmin: FirebaseAuth.instance.currentUser!.uid
                .contains('AcS8yI2U9oQ0I0sgUw15NDdmAIJ3')
            ? true
            : false,
      );
    }).catchError((er) {
      emit(CreateUserWithEmailError());

      print(er.toString());
    });
  }

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  void loginWithGoogle() async {
    emit(LoginWithGoogleLoading());

    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      saveUserData(
        value,
        isAdmin: FirebaseAuth.instance.currentUser!.uid
                .contains('AcS8yI2U9oQ0I0sgUw15NDdmAIJ3')
            ? true
            : false,
      );
      emit(LoginWithGoogleSucsses());
    }).catchError((er) {
      emit(LoginWithGoogleError());

      print(er.toString());
    });
  }

  FacebookLogin facebookLogin = FacebookLogin();
  void loginWithFacebook() async {
    emit(LoginWithFacebookLoading());

    FacebookLoginResult result = await facebookLogin.logIn();
    final accessToken = result.accessToken!.token;
    if (result.status == FacebookLoginStatus.success) {
      final credential = FacebookAuthProvider.credential(accessToken);
      FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        saveUserData(value);
        emit(LoginWithFacebookSucsses());
      }).catchError((er) {
        emit(LoginWithFacebookError());

        print(er.toString());
      });
    }
  }

  UserModel? userModel;
  void saveUserData(
    UserCredential user, {
    String? email,
    String? name,
    String? phone,
    bool? isAdmin = false,
  }) {
    UserModel model = UserModel(
      email: email ?? user.user!.email,
      phone: phone ?? '',
      name: name ?? user.user!.displayName,
      isAdmin: isAdmin,
      id: user.user!.uid,
      bio: '',
      image: '',
      cover: '',
    );
    emit(SaveUserInFireStoreLoading());

    FirebaseFirestore.instance
        .collection(kUser)
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      saveDataInCacheHelper(user.user!.uid);
      emit(SaveUserInFireStoreSucsses());
    }).catchError((er) {
      emit(SaveUserInFireStoreError());

      print(er.toString());
    });
  }

  void saveDataInCacheHelper(value) {
    emit(SaveUserDataInCacheHelperLoading());
    CacheHelper.setData(key: kUid, value: value).then((value) {
      emit(SaveUserDataInCacheHelperSucsses());
    }).catchError((er) {
      emit(SaveUserDataInCacheHelperError());

      print(er.toString());
    });
  }
}
