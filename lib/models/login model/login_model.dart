class ShopLoginModel{
  bool? status;
  String? message;
 late UserData data;
  ShopLoginModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    data=(json['data']!=null ? UserData.fromJson(json['data']): null)!;
  }
}
class UserData {
  int? id;
  String? name;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

 // UserData({
 //   this.id,
   //  this.token,
  //   this.phone,
  //   this.credit,
   //  this.image,
  //   this.name,
  //   this.points
//});
  UserData.fromJson(Map<String,dynamic>json)
  {
id=json['id'];
name=json['name'];
token=json['token'];
phone=json['phone'];
credit=json['credit'];
points=json['points'];
image=json['image'];



  }
}