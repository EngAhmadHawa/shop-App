


import '../models/login model/login_model.dart';

abstract class ShpoLoginStates{}
class ShopLoginInitialState extends ShpoLoginStates{}
class ShopLoginLoadingState extends ShpoLoginStates{}
class ShopLoginSuccessState extends ShpoLoginStates{
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);

}
class ShopLoginErrorState extends ShpoLoginStates{
  late final String error;

  ShopLoginErrorState(String error);
}
class ChangeScureState extends ShpoLoginStates{}
