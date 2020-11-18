import 'package:shared_preferences/shared_preferences.dart';

defaultValues(String token, context) async{
  SharedPreferences storage = await SharedPreferences.getInstance();

  storage.setString('token', token);
}

saveData(email) async {
  SharedPreferences storage = await SharedPreferences.getInstance();

  storage.setString('email', email);
}