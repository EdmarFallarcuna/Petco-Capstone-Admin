import 'package:admin_petco/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../riverpod/general_provider.dart';
import 'error/error_screen.dart';


class WithoutUserPageManager extends ConsumerWidget {
  const WithoutUserPageManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(withOutUserPageProvider);

    if (page == -1) {
      return const ErrorScreen();
    }else if (page == 0) {
      return const SignInScreen();
    } else {
      return const ErrorScreen();
    }
  }
}
