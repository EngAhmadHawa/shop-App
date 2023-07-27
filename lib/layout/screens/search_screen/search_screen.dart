import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/search_model/search_model.dart';
import '../../cubit/shop_layout_cubit.dart';
import 'cubit/search_cubit.dart';
import 'cubit/search_state.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      validator: (String? value){
                        if(value!.isEmpty){
                          return 'enter text to search';
                        }
                        return null;

                      },
                      onFieldSubmitted: (String? text){
                        SearchCubit.get(context).search(text!);
                      },
                        decoration: InputDecoration(
                          labelText: 'Search',
                          prefixIcon: Icon(
                            Icons.search_outlined,
                          ),)
                    ),

                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildGridProduct(
                            SearchCubit.get(context).model!.data!.data![index],
                            context,
                          ),
                          separatorBuilder: (context, index) => const SizedBox(height: 5),
                          itemCount:
                          SearchCubit.get(context).model!.data!.data!.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget buildGridProduct(Product model, context) => Container(
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
               '${ model.image}',
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
                '${model.name}',
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

}