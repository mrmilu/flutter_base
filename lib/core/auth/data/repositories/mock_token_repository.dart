import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_base/core/app/domain/models/environments_list.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/auth/domain/models/change_password_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/login_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/sign_up_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/token_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ITokenRepository, env: localEnvironment)
class MockTokenRepository implements ITokenRepository {
  final _faker = Faker.instance;

  @override
  Future<void> clear() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<String> getToken() async {
    return _faker.datatype.uuid();
  }

  @override
  Future<void> update(TokenModel token) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
