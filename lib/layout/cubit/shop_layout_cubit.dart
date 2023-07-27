import 'package:bloc/bloc.dart';
import '../../models/categories_model/categories_model.dart';
import '../../models/change_favorites_model/change_favorites_model.dart';
import '../../models/get_fvorites/get_favorites.dart';
import '../../models/home_model/home_model.dart';
import '../../models/login model/login_model.dart';
import '../../shared/dio_helper/dio_helper.dart';
import '../../shared/remot/end_points.dart';
import '../../utils/constant.dart';
import '../screens/categories_screen/categories_screen.dart';
import '../screens/fourait_screen/favorate_screen.dart';
import '../screens/product_screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/settings_screen/settings_screen.dart';
import 'shop_layout_states.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() :super (ShopLayoutInitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget>Screens = [
    productScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),

  ];

  void changeNavigatBottom(int index) {
    currentIndex = index;
    if(index==2){
      getFavorites();
    }
    emit(ShopLayoutChangeNavigatState());
  }

  HomeModel? homeModel;
  Map<int?,bool?>favorits={};
  void getHomeData() {
    emit(ShopLoadingHomeData());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
     homeModel!.data?.products?.forEach((element) {
      favorits.addAll({
        element.id: element.inFavorites,
      });
     });
      emit(ShopSuccessHomeData(homeModel!));
    }).catchError((error) {
      emit(ShopErrorHomeData());
      print(error.toString());
    });
  }

CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value){
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesData());

    }).catchError((error){
      print(error.toString());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId){
    favorits[productId]= !favorits[productId]!;
    emit(ShopSuccessChangeFavoritesColorData());
    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data: {
          'product_id':productId,
        }).then((value){
          changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
          print(value.data);
          if(!changeFavoritesModel!.status!){
            favorits[productId]=!favorits[productId]!;
            emit(ShopErrorChangeFavoritesData());
          }

          emit(ShopSuccessChangeFavoritesData());
    }).catchError((error){
      favorits[productId]=!favorits[productId]!;
      emit(ShopErrorChangeFavoritesData());
      print(error.toString());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesData());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesData());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesData());
    });
  }
  ShopLoginModel? userData;
  void getUserData() {
    emit(ShopLoadingGetUserData());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserData());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserData());
    });
  }
  void updateUserData({
    required String name,
   // required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        //'email': email,
        'phone': phone,
      },
    ).then((value) {
      userData= ShopLoginModel.fromJson(value.data);
      print(userData!.data!.name);

      emit(ShopSuccessUpdateUserState(userData!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}