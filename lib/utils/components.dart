import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



Widget defaultBottom({

required Null Function() onPressed,
  Color color=Colors.teal,
  required String text,
  bool isUpperCase= true,
  double width=double.infinity,
})


=> Container(
   width:width,
  child: MaterialButton(
    onPressed: onPressed,
    color: color,
    height: 40,

    child: Text(
     isUpperCase? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);

Widget defaultTextBottom({
  required Null Function() onPressed,
  required  String text,
  Color? color,
})=>TextButton(
onPressed: onPressed,
child: Text(text.toUpperCase()),

);


Widget buildTaskItem(Map model ,context)=>Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child:Text('${model['time']}') ,
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '${model ['date']}',
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          IconButton(
            color: Colors.green,
              onPressed: (){
              // AppCubit.get(context).updateData(
              //     status: 'done',
              //     id: model['id'],);
              },
              icon:Icon(Icons.check_box)),
          IconButton(
            color: Colors.black54,
              onPressed: ()
              {
                // AppCubit.get(context).updateData(
                //     status: 'archived',
                //     id: model['id']
                // );
              },
              icon:Icon(Icons.archive)),

        ],
      )
    ],
  ),
);

Widget buildArticelItem(article,context)=>Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image:DecorationImage(
            image: NetworkImage(
                'https://wallpaperaccess.com/full/2702421.jpg'
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(
        width: 20,),
      Container(
        height: 120.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'title',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1,
            ),

            Text(
              '2021-04-02t11:43:00z',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

void navigateAndFinish(
context,
widget,
)=>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context)=>widget),
            ( Route<dynamic>  route) => false
    );

void showToast({
  required String text,
  required ToastStates state
})=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: choseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates{SUCCESS,ERROR,WARNING}
Color choseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
  return color;
}

Widget defaultText({
  required Function function,
  required TextEditingController controller,

})=>TextFormField(
  validator:(String){function();},
  controller: controller,
  keyboardType:TextInputType.emailAddress ,
  decoration: InputDecoration(
    labelText: 'Email Address',
    border: OutlineInputBorder(),
    prefixIcon: Icon(
      Icons.email,
    ),

  ),
);
