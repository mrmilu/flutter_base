import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_primary.dart';
import 'package:flutter_base/ui/components/flutter_base_app_bar.dart';
import 'package:flutter_base/ui/components/form/email_reactive_input.dart';
import 'package:flutter_base/ui/components/form_scaffold.dart';
import 'package:flutter_base/ui/components/text/high_text.dart';
import 'package:flutter_base/ui/components/text/small_text.dart';
import 'package:flutter_base/ui/components/views/column_scroll_view.dart';
import 'package:flutter_base/ui/features/auth/views/forgot_password/providers/forgot_password_provider.dart';
import 'package:flutter_base/ui/features/auth/views/forgot_password/view_models/forgot_password_view_model.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/styles/insets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FormScaffold(
      appBar: FlutterBaseAppBar.dialog(),
      body: SafeArea(
        child: ColumnScrollView(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          padding: Insets.h24,
          children: [
            BoxSpacer.v16(),
            HighTextL(LocaleKeys.forgotPassword_title.tr()),
            BoxSpacer.v24(),
            SmallTextM(LocaleKeys.forgotPassword_claim.tr()),
            BoxSpacer.v16(),
            ForgotPasswordModelFormBuilder(
              model: ForgotPasswordViewModel(),
              builder: (context, formModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    EmailReactiveInput(
                      key: const Key('forgot-password-email'),
                      placeholder:
                          LocaleKeys.forgotPassword_form_email_label.tr(),
                      formControl: formModel.emailControl,
                    ),
                    BoxSpacer.v24(),
                    _ContinueButton(formModel: formModel),
                    BoxSpacer.v16(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.formModel});
  final ForgotPasswordModelForm formModel;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return ReactiveForgotPasswordModelFormConsumer(
          builder: (context, consumer, _) {
            return ButtonPrimary(
              key: const Key('forgot-password-button'),
              text: LocaleKeys.forgotPassword_form_submit.tr(),
              onPressed: consumer.form.valid
                  ? () => ref
                      .read(forgotPasswordProvider)
                      .requestChangePassword(formModel)
                  : null,
            );
          },
        );
      },
    );
  }
}
