import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope/layout/cubit/shop_layout_cubit.dart';
import 'package:shope/layout/cubit/shop_layout_states.dart';
import 'package:shope/login/shop_login_screen.dart';
import 'package:shope/shared/cashe/cashe_helper.dart';
import 'package:shope/shared/dio_helper/dio_helper.dart';
import 'package:shope/utils/constant.dart';
import 'bloc_observer.dart';
import 'layout/shop_layout.dart';
import 'onboardingscreen/on_boarding_screen.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  var onBoarding=CacheHelper.getData(key: 'onBoarding');
  token=CacheHelper.getData(key: 'token');
  if(token!=null){
  if(onBoarding!=null){

      widget=ShopLayout();
      print(token);
      print(onBoarding);
    }else{
      widget=ShopLoginScreen();
    }

  }else{
    widget=OnBoardingScreen();
  }
  runApp( MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final  Widget? startWidget;

  const MyApp({super.key,this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(BuildContext context)=>ShopLayoutCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData() ,
    child: BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      builder: (BuildContext context,state){
            return  MaterialApp(
          debugShowCheckedModeBanner: false,
          home:startWidget,
        );
      },
      listener: (context,state){},
    ),
    );

  }
}


