import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope/layout/cubit/shop_layout_cubit.dart';
import '../../../models/change_favorites_model/change_favorites_model.dart';
import '../../../models/get_fvorites/get_favorites.dart';
import '../../cubit/shop_layout_states.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      builder: (context,state)=> ConditionalBuilder(
        condition:ShopLayoutCubit.get(context).favoritesModel!.data!.data!.isNotEmpty  ,
        builder: ( context) {
          return  ListView.builder(
            shrinkWrap: true,
              itemCount: ShopLayoutCubit.get(context).favoritesModel!.data!.data!.length,
              itemBuilder:(context,index){
                return buildGridProduct(ShopLayoutCubit.get(context).favoritesModel!.data!.data![index],context);
              });
        },
        fallback: (context) =>
        const Center(child: CircularProgressIndicator()),
      ),

      listener: (context,index){},
    );
  }
  Widget buildGridProduct(FavoritesData model, context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              height: 200.0,
              width: double.infinity,
              image: NetworkImage(
              '${model.product!.image}'
              ),
            ),
            if (model.product!.discount != 0)
              Container(
                width: 55,
                height: 20,
                color: Colors.red,
                child: Center(
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                '${model.product!.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.product!.price}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (model.product!.discount != 0)
                    Text(
                      '${model.product!.oldPrice}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                 const Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                        ),

                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  }


