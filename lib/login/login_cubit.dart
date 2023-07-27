import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/login model/login_model.dart';
import '../shared/dio_helper/dio_helper.dart';
import '../shared/remot/end_points.dart';
import 'login_states.dart';



class ShopLoginCubit extends Cubit<ShpoLoginStates>{
  ShopLoginCubit() :super (ShopLoginInitialState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  late ShopLoginModel loginModel;
  void userLogin({
  required String email,
    required String password
})
  {
    emit(ShopLoginLoadingState());
DioHelper.postData(url: LOGIN,
    data: {
  'email':email,
      'password':password,
    }).then((value) {
      print(value.data);
   loginModel=ShopLoginModel.fromJson(value.data);


      emit(ShopLoginSuccessState(loginModel));
}).catchError((error){
  print(error.toString());
  emit(ShopLoginErrorState(error.toString()));
});
  }
  bool isScure=true;
  void changeScure(){
    isScure=!isScure;
    emit(ChangeScureState());
  }
}