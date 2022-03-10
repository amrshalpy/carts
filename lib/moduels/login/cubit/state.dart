abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginWithEmailLoading extends LoginState {}

class LoginWithEmailSucsses extends LoginState {}

class LoginWithEmailError extends LoginState {}

class LoginWithGoogleLoading extends LoginState {}

class LoginWithGoogleSucsses extends LoginState {}

class LoginWithGoogleError extends LoginState {}

class LoginWithFacebookLoading extends LoginState {}

class LoginWithFacebookSucsses extends LoginState {}

class LoginWithFacebookError extends LoginState {}

class CreateUserWithEmailLoading extends LoginState {}

class CreateUserWithEmailSucsses extends LoginState {}

class CreateUserWithEmailError extends LoginState {}

class SaveUserInFireStoreLoading extends LoginState {}

class SaveUserInFireStoreSucsses extends LoginState {}

class SaveUserInFireStoreError extends LoginState {}

class SaveUserDataInCacheHelperLoading extends LoginState {}

class SaveUserDataInCacheHelperSucsses extends LoginState {}

class SaveUserDataInCacheHelperError extends LoginState {}
