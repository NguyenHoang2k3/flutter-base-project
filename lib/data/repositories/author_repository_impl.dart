import 'dart:convert';
import 'package:flutter_clean_architecture/data/remote/models/respone/login_info_response.dart';
import 'package:flutter_clean_architecture/domain/entities/current_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/author_repository_repository.dart';
import '../../shared/common/error_entity/business_error_entity.dart';

@Injectable(as: AuthorRepositoryRepository)
class AuthorRepositoryRepositoryImpl extends AuthorRepositoryRepository {
  AuthorRepositoryRepositoryImpl();

  @override
  Future<CurrentUser> login({
    required String username,
    required String password,
    required bool isRemember,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    if (username == 'user' && password == '1') {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final CurrentUser currentUser = CurrentUser('','','','','','','','');
      await saveUserToPreferences(currentUser);
      if(isRemember) {
        await prefs.setString('username', username);
        await prefs.setString('password', password);
      }
      else {
        await prefs.setString('username', '');
        await prefs.setString('password', '');
      }
      return currentUser;
    } else {
      throw BusinessErrorEntityData(
        name: 'Login Failed',
        message: 'UserName or PassWord faild',
      );
    }
  }

  Future<void> saveUserToPreferences(CurrentUser user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('currentUser', userJson);
  }


  @override
  Future<CurrentUser> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id =  prefs.getString('currentUserId');
    String? imagePath =  prefs.getString('currentImagePath');
    String? fullName =  prefs.getString('currentFullName');
    String? username =  prefs.getString('currentUsername');
    String? email =  prefs.getString('currentEmail');
    String? phoneNumber =  prefs.getString('currentPhoneNumber' );
    String? bio =  prefs.getString('currentBio');
    String? website =  prefs.getString('currentWebsite');
    CurrentUser currentUser = CurrentUser('','','','','','','','');
    return currentUser;
  }

  @override
  Future<bool> loginByGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return false; // Người dùng cancel login
      }

      // Tạo đối tượng CurrentUser từ thông tin googleUser
      final currentUser = CurrentUser(
        googleUser.id,
        googleUser.displayName ?? '',
        googleUser.photoUrl ?? '',
        googleUser.displayName ?? '',
        googleUser.email,
        '',
        'Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian',
        '',
      );

      await saveUserToPreferences(currentUser);
      return true;

    } catch (e, s) {
      print("Login failed: $e");
      return false;
    }
  }

  @override
  Future<LoginInfoResponse> checkRememberPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? password = prefs.getString('password');
    if((password??'').isEmpty) {
      return LoginInfoResponse(username: '', password: '');
    }
    else{
      String? username = prefs.getString('username');
      String? password = prefs.getString('password');
      return LoginInfoResponse(username: username ??'', password:password??'');
    }

  }
}
