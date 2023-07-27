
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPreferences;
  static init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  Future<bool>? putData({
   required String key,
    required bool value,
})async
{
   return await sharedPreferences.setBool(key, value);
  }

static dynamic  getData({
    required String key,
  })
  {
    return  sharedPreferences.get(key);
  }

 static Future<bool?> saveData({
    required String key,
    required dynamic value,
})async{
if(value is String) {
  return await sharedPreferences.setString(key, value);
}
if(value is int) {
  return await sharedPreferences.setInt(key, value);
}
if(value is bool) {
  return await sharedPreferences.setBool(key, value);
}

return await sharedPreferences.setDouble(key, value);


  }
}






// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class UserSecureStorage{
// // Create storage
//  static final storage = new FlutterSecureStorage();
// static const keyuId='uId';
//
// static Future setuId(String uId)async=>
//     await storage.write(key: keyuId,value: uId);
//
// static Future<String?>getuId({required String key})async=>
//     await storage.read(key: keyuId);
//
// }

