import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/auth_controller.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Future<void> login() => ref.read(authControllerProvider.notifier).login(
      'myEmail',
      'myPassword',
    );

    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('login'),),
    );
  }
}
