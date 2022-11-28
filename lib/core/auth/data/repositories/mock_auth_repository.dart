import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_base/core/app/domain/models/enviroments_list.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/models/change_password_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/login_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/sign_up_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/social_auth_user.dart';
import 'package:flutter_mrmilu/flutter_mrmilu.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IAuthRepository, env: localEnviroment)
class MockAuthRepository implements IAuthRepository {
  final _faker = Faker.instance;

  @override
  Future<String> login(LoginInputModel input) async {
    return _faker.datatype.uuid();
  }

  @override
  Future logout() async {
    Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<String> signUp(SignUpInputModel input) async {
    return _faker.datatype.uuid();
  }

  @override
  Future<SocialAuthUser> appleSocialAuth() async {
    return SocialAuthUser(
      name: _faker.frontMock(_faker.name.firstName()),
      email: _faker.email(),
      password: _faker.datatype.uuid(),
    );
  }

  @override
  Future<SocialAuthUser> googleSocialAuth() async {
    return SocialAuthUser(
      name: _faker.frontMock(_faker.name.firstName()),
      email: _faker.email(),
      password: _faker.datatype.uuid(),
    );
  }

  @override
  Future<void> requestResetPassword(String email) async {
    Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> changePassword(ChangePasswordInputModel input) async {
    Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> resendPasswordResetEmail(String email) async {
    Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> verifyAccount(String token) async {
    Future.delayed(const Duration(milliseconds: 300));
  }
}
