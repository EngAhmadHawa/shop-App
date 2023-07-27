import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope/layout/cubit/shop_layout_states.dart';

import '../../../utils/colors.dart';
import '../../cubit/shop_layout_cubit.dart';


class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopLayoutCubit.get(context).userData;

          nameController.text = model!.data.name!;

          phoneController.text = model.data.phone!;

        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).userData != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children:
                [
                  if(state is ShopLoadingUpdateUserState)
                    const LinearProgressIndicator(color: AppColors.defaultColor,),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (String? value){
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText:'Name',
                      prefixIcon: Icon(Icons.person_outline),

                    ),
                  ),

                  const SizedBox(
                    height: 40.0,
                  ),


                  TextFormField(
                    controller: phoneController,
                    validator: (String? value){
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText:'Phone',
                      prefixIcon: Icon(Icons.phone_outlined),

                    ),
                  ),

                  const SizedBox(
                    height: 20.0,
                  ),

                  ConditionalBuilder(
                    condition: state is! ShopLoadingUpdateUserState,
                    builder: (context)=>
                        InkWell(
                          onTap: ()
                          { if(formKey.currentState!.validate())
                          {
                          ShopLayoutCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                   //       email: emailController.text,
                          );
                          }

                          },
                          child: Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.defaultColor,
                            ),
                            child: const Center(child: Text('Update',style: TextStyle(color: AppColors.white),)),
                          ),
                        ),
                    fallback: (context)=>const Center(child: CircularProgressIndicator()),

                  ),

                  const SizedBox(
                    height: 20.0,
                  ),

                  // InkWell(
                  //   onTap: ()
                  //   { if(formKey.currentState!.validate())
                  //   {
                  //     ShopLayoutCubit.get(context).updateUserData(
                  //       name: nameController.text,
                  //       phone: phoneController.text,
                  //    //   email: emailController.text,
                  //     );
                  //   }
                  //
                  //   },
                  //   child: Container(
                  //     width: 150,
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: AppColors.defaultColor,
                  //     ),
                  //     child: const Center(child: Text('Update',style: TextStyle(color: AppColors.white),)),
                  //   ),
                  // )

              
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator(color: AppColors.defaultColor,)),
        );
      },
    );
  }
}