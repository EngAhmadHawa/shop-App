import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../../models/categories_model/categories_model.dart';
import '../../cubit/shop_layout_cubit.dart';
import '../../cubit/shop_layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) =>ConditionalBuilder(
        condition: ShopLayoutCubit.get(context).categoriesModel!=null,
        builder:(context)=> ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index)=>buildeCategories(ShopLayoutCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (BuildContext context, int index) =>
              Container(
                width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
              child: SizedBox(height:10,)),
          itemCount:ShopLayoutCubit.get(context).categoriesModel!.data!.data.length ,),
        fallback:(context)=> Center(child: CircularProgressIndicator()),
      ),

    );
  }
Widget buildeCategories(DataModel model)=>Padding(
  padding: const EdgeInsets.all(10.0),
  child: Column(
    children: [

      Row(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),),
            child: Image(
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              image: NetworkImage(
                '${model.image}'
              ),),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            '${model.name}',
            style: TextStyle(
              fontWeight: FontWeight.bold,

            ),
          ),
          Spacer(),
          Icon(
              Icons.navigate_next),
        ],
      ),
    ],
  ),
);
}
