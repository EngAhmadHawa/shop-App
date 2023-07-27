

import 'package:shope/models/login%20model/login_model.dart';

import '../../models/home_model/home_model.dart';

abstract class ShopLayoutStates{}

class ShopLayoutInitialState extends ShopLayoutStates{}

class ShopLayoutChangeNavigatState extends ShopLayoutStates{}

class ShopLoadingHomeData extends ShopLayoutStates{}

class ShopSuccessHomeData extends ShopLayoutStates{
  ShopSuccessHomeData(HomeModel homeModel);
}

class ShopErrorHomeData extends ShopLayoutStates{}

class ShopSuccessCategoriesData extends ShopLayoutStates{}

class ShopErrorCategoriesData extends ShopLayoutStates{}
class ShopSuccessChangeFavoritesColorData extends ShopLayoutStates{}

class ShopSuccessChangeFavoritesData extends ShopLayoutStates{}
class ShopErrorChangeFavoritesData extends ShopLayoutStates{}

class ShopSuccessGetFavoritesData extends ShopLayoutStates{}

class ShopErrorGetFavoritesData extends ShopLayoutStates{}
class ShopLoadingGetFavoritesData extends ShopLayoutStates{}

class ShopSuccessGetUserData extends ShopLayoutStates{}

class ShopErrorGetUserData extends ShopLayoutStates{}
class ShopLoadingGetUserData extends ShopLayoutStates{}

class ShopLoadingUpdateUserState extends ShopLayoutStates{}
class ShopSuccessUpdateUserState extends ShopLayoutStates{
  ShopSuccessUpdateUserState(ShopLoginModel shopLoginModel);
}
class ShopErrorUpdateUserState extends ShopLayoutStates{}

