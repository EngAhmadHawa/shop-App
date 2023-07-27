import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../../models/categories_model/categories_model.dart';
import '../../../models/home_model/home_model.dart';
import '../../cubit/shop_layout_cubit.dart';
import '../../cubit/shop_layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class productScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopLayoutCubit.get(context).homeModel != null &&
                ShopLayoutCubit.get(context).categoriesModel != null,
            builder: (context) => productsBuilder(
                ShopLayoutCubit.get(context).homeModel!,
                ShopLayoutCubit.get(context).categoriesModel!,
                context),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget productsBuilder(
          HomeModel model, CategoriesModel categories, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model.data?.banners!
                    .map(
                      (e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            buildCategoris(categories.data!.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10.0,
                            ),
                        itemCount: categories.data!.data.length),
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.55,
                children: List.generate(
                    model.data!.products!.length,
                    (index) => buildGridProduct(
                        model.data!.products![index], context)),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(Products model, context) => Container(
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
                    model.image,
                  ),
                ),
                if (model.discount != 0)
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
                    model.name,
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
                        '${model.price.round()}',
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
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        //color: Colors.deepOrange,
                        onPressed: () {
                          ShopLayoutCubit.get(context).changeFavorites(model.id as int);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                            radius: 20.0,
                            backgroundColor:ShopLayoutCubit.get(context).favorits[model.id]! ? Colors.deepOrange:Colors.grey ,
                            child: Icon(
                              Icons.favorite_outline,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoris(DataModel categories) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            image: NetworkImage('${categories.image}'),
          ),
          Container(
            width: 100.0,
            color: Colors.black54,
            child: Text(
              '${categories.name} ',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
