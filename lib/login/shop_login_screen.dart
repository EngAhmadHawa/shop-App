import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shope/shared/cashe/cashe_helper.dart';
import 'package:shope/utils/colors.dart';

import '../layout/shop_layout.dart';
import '../register/shop_register_screen.dart';
import '../utils/components.dart';
import '../utils/constant.dart';
import 'login_cubit.dart';
import 'login_states.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailcontroller=TextEditingController();

  var passwordController=TextEditingController();
  OutlineInputBorder MyInputBorder(){ //return type is OutlineInputBorder
    return const OutlineInputBorder( //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
          color:Colors.redAccent,
          width: 3,
        )
    );
  }


  @override
  Widget build(context) {
    return BlocProvider(

      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShpoLoginStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
            ),

            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: AppColors.defaultColor,
                              fontWeight: FontWeight.bold
                          ),


                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),


                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          validator: ( value){
                            if(value!.isEmpty){
                              return 'email text must not empty';
                            }return null;
                          },
                          controller: emailcontroller,
                          keyboardType:TextInputType.emailAddress ,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            border: MyInputBorder(),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: AppColors.defaultColor,
                            ),

                          ),
                        ),
                        const SizedBox(
                          height:15.0 ,),
                        TextFormField(
                          onFieldSubmitted: (value){
    if(formKey.currentState!.validate()){
    ShopLoginCubit.get(context).userLogin(
    email: emailcontroller.text,
    password: passwordController.text);
                          };},
                          validator:(value){
                            if(value!.isEmpty){
                              return 'password must not empty';
                            }
                            return null;
                          },
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: ShopLoginCubit.get(context).isScure,
                          decoration: InputDecoration(
                            border: MyInputBorder(),
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline,color: AppColors.defaultColor,),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ShopLoginCubit.get(context).changeScure();
                              },
                              icon: const Icon(Icons.visibility,color: AppColors.defaultColor,),),

                          ),
                        ),
                        SizedBox(
                          height:20.0 ,),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context)=>
                          InkWell(
                            onTap: ()
                            {
                            if(formKey.currentState!.validate()){
                            ShopLoginCubit.get(context).userLogin(
                            email: emailcontroller.text,
                            password: passwordController.text);
                           // navigateAndFinish(context,ShopLayout());
                            }
                            },
                            child: Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.defaultColor,
                              ),
                              child: Center(child: Text('LOGIN',style: TextStyle(color: AppColors.white),)),
                            ),
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),

                        ),
                        Row(
                          children: [
                            Text(

                              'don\'t have an account?',
                            ),
                        TextButton(onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>ShopRegisterScreen()));
                        }, child: Text('REGISTER',style: TextStyle(color: AppColors.defaultColor,fontSize: 15),)


                            ),
                          ],
                        ),


                      ],

                    ),
                  ),
                ),
              ),
            ),


          );
        },
        listener: (BuildContext context, Object? state) {
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status!){
              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token ).then((value){
                navigateAndFinish(
                    context,
                    ShopLayout()
                );
              });

            }else
            {
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message!,
                  state:ToastStates.ERROR);

            }
          }
        },

      ),
    );
  }
}


