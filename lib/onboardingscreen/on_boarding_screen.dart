import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shope/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/shop_login_screen.dart';
import '../shared/cashe/cashe_helper.dart';
import '../utils/components.dart';


class BoardingModel
{
  final String image;
  final String title;
  final String body;
  BoardingModel({
 required this.image,
  required this.title,
  required this.body,

});

}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}
class _OnBoardingScreenState extends State<OnBoardingScreen> {

  void skip(){
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true).then((value){
      if(value!){
        navigateAndFinish(
            context,
            ShopLoginScreen());
      }
    });
  }
  var boardController=PageController();

List<BoardingModel>boarding=[
  BoardingModel(
      image: 'asset/images/shop.png',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body'
  ),
  BoardingModel(
      image: 'asset/images/shop.png',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body'
  ),
  BoardingModel(
      image: 'asset/images/shop.png',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body'
  ),
];

bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
       actions: [InkWell(
            onTap: () => skip(),
            child: const Text('SKIP',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.defaultColor),)),

]
      ),
body:Padding(
  padding: const EdgeInsets.all(30.0),
  child:   Column(
    children:
    [

      Expanded(
        child: PageView.builder(

          physics: BouncingScrollPhysics(),
         onPageChanged: (int index){
            if(index==boarding.length -1)
            {
              setState(() {
                isLast=true;
              });
            }else
            {
              setState(() {
                isLast=false;
              });
            }
         },
          controller: boardController,
            itemBuilder:(context,index)=> buildBoardingItem(boarding[index]),
          itemCount: boarding.length,
        ),
      ),
      SizedBox(
        height: 40,
      ),

      Row(
        children:
        [
          SmoothPageIndicator(
              controller: boardController,
              effect: const ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: AppColors.defaultColor,
                dotHeight: 10,
                expansionFactor: 4,
                dotWidth: 10,
                spacing: 5,

              ),
              count: boarding.length),
          const Spacer(),
          FloatingActionButton(
            backgroundColor: AppColors.defaultColor,
              onPressed: ()
              {
                if(isLast)
                  {
                    skip();
                  }else{
                  boardController.nextPage(
                      duration: const Duration(
                          milliseconds: 500
                      ),
                      curve: Curves.fastLinearToSlowEaseIn);
                }

              },
            child:const Icon(Icons.arrow_forward_ios,color: Colors.white) ,
          ),
        ],
      )
    ],
  ),
),
    );

  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),
    ],
  ) ;
}
