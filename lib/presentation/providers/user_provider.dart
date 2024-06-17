import 'package:clean_code/domain/models/user_model.dart';
import 'package:clean_code/domain/repositories/user_repository.dart';
import 'package:clean_code/infraestructure/repositories/user_repository_impl.dart';
import 'package:flutter/material.dart';


class UserProvider extends ChangeNotifier {
  UserModel? _user;
  final UserRepository _userRepository = UserRepositoryImpl();
  String? _token;

  UserModel? get user => _user;
 
  Future<void> login(String email, String password) async {
    _user = await _userRepository.loginUser(email, password);
    _token = _user?.token;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}