import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope/layout/screens/search_screen/search_screen.dart';
import 'package:shope/utils/colors.dart';
import 'cubit/shop_layout_cubit.dart';
import 'cubit/shop_layout_states.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

      return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
        listener: (BuildContext context, Object? state) {  },
        builder: (BuildContext context, state) {
          var cubit=ShopLayoutCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              leading: Icon(Icons.shopping_cart_outlined,color: AppColors.defaultColor,size: 35,),
              actions: [
                IconButton(
                    onPressed: (){
                      Navigator.push((context),
                          MaterialPageRoute
                            (builder: (context)=>SearchScreen()));

                    },
                    icon: Icon(Icons.search,color: Colors.black,))
              ],
            ),

            body: cubit.Screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar (
              fixedColor: AppColors.defaultColor,
              type:BottomNavigationBarType.fixed ,
              onTap: (index){
                cubit.changeNavigatBottom(index);
                },
              currentIndex: cubit.currentIndex,
              items: [

                BottomNavigationBarItem(

                    label: 'Home',
                    icon: Icon(Icons.home_outlined)),
                BottomNavigationBarItem(
                    label: 'Categorys',
                    icon: Icon(Icons.category_outlined)),
                BottomNavigationBarItem(
                    label: 'Favorate',
                    icon: Icon(Icons.favorite_outline)),
                BottomNavigationBarItem(
                    label: 'Settings',
                    icon: Icon(Icons.settings_outlined)),


              ],

            ),
          );
        },


    );
  }
}
