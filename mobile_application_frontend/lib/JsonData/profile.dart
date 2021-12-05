import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Profile{
  var name;
  var email;
  var mobile;
  var userId;
  Future<void> retrieveInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    userId = decodedToken['userId'];
    print('$decodedToken');
    var url = "https://smartcheckout.tech/api/v1/buyer/user/$userId";
    var response = await http.get(Uri.encodeFull(url), headers: {
      "x-auth-token": token,
    });
    print('hi2');
    print('${response.statusCode}');
    print('${response.body}');
    var jsonData = json.decode(response.body);
    var userProfile = jsonData['userProfile'];
    print('$userProfile');
    name = userProfile['name'];
    email = userProfile['email'];
    mobile = userProfile['mobile'];
    sharedPreferences.setString("name", name);
    sharedPreferences.setString("email", email);
    sharedPreferences.setInt("mobile", mobile);

  }
}