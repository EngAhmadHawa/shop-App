class CategoriesModel{
  bool? states;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String,dynamic>json){
    states=json['status'];
    data=CategoriesDataModel.fromJson(json['data']) ;

  }

}
class CategoriesDataModel{
  int? curntPage;
  List<DataModel>data=[];
  CategoriesDataModel.fromJson(Map<String,dynamic>json){
    curntPage=json['currrent_page'];
    json['data'].forEach((element){
data.add(DataModel.fromJson(element));
    });
   // data=json['data'];
  }

  }
class DataModel
{
  int? id;
  String? name;
  String? image;
  DataModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }}
