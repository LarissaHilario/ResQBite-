import 'dart:convert';
import 'package:clean_code/domain/models/user_model.dart';
import 'package:clean_code/domain/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserModel> loginUser(String email, String password) async {
    const url = 'http://3.223.7.73/signin/';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body);
      return UserModel(token: token, email: email);
    } else {
      print('errorrrr');
      throw Exception('Failed to login');   
    }
  }
}
