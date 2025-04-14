import 'package:flutter_clean_architecture/data/remote/models/respone/login_info_response.dart';
import 'package:flutter_clean_architecture/domain/entities/current_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/author_repository_repository.dart';
import '../../shared/common/error_entity/business_error_entity.dart';
import '../../shared/utils/logger.dart';

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
      await saveUserToShareRefrence(currentUser);
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

  Future<CurrentUser> saveUserToShareRefrence(CurrentUser currentUser) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentUserId', '');
      await prefs.setString('currentImagePath', '');
      await prefs.setString('currentFullName',  '');
      await prefs.setString('currentUsername', '');
      await prefs.setString('currentEmail', '');
      await prefs.setString('currentPhoneNumber', '');
      await prefs.setString('currentBio', '');
      await prefs.setString('currentWebsite', '');

      return currentUser;
    } catch (e) {
      logger.d('$e');
      throw BusinessErrorEntityData(
        name: 'error',
        message: 'error',
      );
    }
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
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
/*
      if (googleUser == null) {
        return false;
      }

      final GoogleSignInAuthentication? googleAuth =
      await googleUser.authentication;

      if (googleAuth == null) {
        return false;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final CurrentUser currentUser = CurrentUser(
        userCredential.user?.uid ?? '',
        userCredential.user?.displayName,
        userCredential.user?.photoURL,
        userCredential.user?.email?.split('@').first ?? '',
        userCredential.user?.email ?? '',
        userCredential.user?.phoneNumber ?? '',
        '',
        '',
      );

      await saveUserToShareRefrence(currentUser);*/

      return true;
    } catch (e) {
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
