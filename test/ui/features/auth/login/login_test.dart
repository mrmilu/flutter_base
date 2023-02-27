import 'package:flutter/material.dart';
import 'package:flutter_base/common/interfaces/notifications_service.dart';
import 'package:flutter_base/core/app/domain/models/app_error.dart';
import 'package:flutter_base/core/app/domain/models/environments_list.dart';
import 'package:flutter_base/core/app/ioc/locator.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/auth/domain/models/login_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/token_model.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:flutter_base/ui/features/auth/views/login/login_page.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/pump_app.dart';

const emailString = 'test@test.com';
const passwordString = 'password';

class FakeLoginInputModel extends Fake implements LoginInputModel {}

void main() {
  // Configure global dependency injection
  configureDependencies(env: Environments.test);

  setUpAll(() {
    registerFallbackValue(FakeLoginInputModel());
    registerFallbackValue(TokenModel());
  });

  group('Login Page Widget Tests', () {
    setUpAll(() {
      final tokenRepo = getIt<ITokenRepository>();
      when(() => tokenRepo.update(any())).thenAnswer((_) async {});
      final notificationService = getIt<INotificationsService>();
      when(() => notificationService.getToken()).thenAnswer((_) async => null);
      final userRepo = getIt<IUserRepository>();
      when(() => userRepo.getLoggedUser()).thenAnswer(
        (_) async => const User(email: '', name: ''),
      );
    });

    testWidgets(
      'When enter valid credentials user enter in app',
      (tester) async {
        await tester.pumpApp(const LoginPage());

        final authRepo = getIt<IAuthRepository>();
        when(() => authRepo.login(any())).thenAnswer((_) async => 'token');

        await _enterLoginCredentials(tester);
        await _tapLoginButton(tester);

        final container = getIt<ProviderContainer>();
        expect(container.read(userProvider).userData, isNotNull);
      },
    );

    testWidgets(
      'When enter invalid credentials show error message',
      (tester) async {
        await tester.pumpApp(const LoginPage());

        final authRepo = getIt<IAuthRepository>();
        when(() => authRepo.login(any()))
            .thenThrow(const AppError(message: 'Bad credentials'));

        await _enterLoginCredentials(tester);
        await _tapLoginButton(tester);

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Bad credentials'), findsOneWidget);
      },
    );
  });
}

Future<void> _tapLoginButton(WidgetTester tester) async {
  final signInButton = find.byKey(const Key('sing_in_button'));
  await tester.tap(signInButton);
  await tester.pumpAndSettle();
}

Future<void> _enterLoginCredentials(WidgetTester tester) async {
  final email = find.byKey(const Key('sing_in_email'));
  final pass = find.byKey(const Key('sing_in_pass'));
  await tester.enterText(email, emailString);
  await tester.enterText(pass, passwordString);
  await tester.pumpAndSettle();
}
