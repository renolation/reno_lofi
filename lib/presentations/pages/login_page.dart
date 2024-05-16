import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reno_music/state/auth_jelly_controller.dart';
import '../../data/user_credentials.dart';
import '../../state/auth_controller.dart';
import '../widgets/labeled_text_field.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {



    final error = useState('');

    final serverUrlInputController = useTextEditingController(text: 'https://music.renolation.com');
    final emailInputController = useTextEditingController(text: 'renolation');
    final passwordInputController = useTextEditingController(text: 'renolation');

    Widget serverURLField() => LabeledTextField(
      label: 'Server URL',
      keyboardType: TextInputType.url,
      controller: serverUrlInputController,
      textInputAction: TextInputAction.next,
    );
    Widget loginField() => LabeledTextField(
      label: 'Login',
      keyboardType: TextInputType.text,
      controller: emailInputController,
      textInputAction: TextInputAction.next,
    );
    Widget passwordField() => LabeledTextField(
      label: 'Password',
      controller: passwordInputController,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
    );

    Future<void> signIn() async {
      final userCredentials = UserCredentials(
        username: emailInputController.text.trim(),
        pw: passwordInputController.text.trim(),
        serverUrl: serverUrlInputController.text.trim(),
      );

      if (userCredentials.serverUrl.isEmpty || userCredentials.username.isEmpty || userCredentials.pw.isEmpty) {
          error.value = 'Server URL, login and password are required';
        return;
      }

      if (!Uri.parse(userCredentials.serverUrl).isAbsolute) {
        error.value = 'Server URL is invalid. Should start with http/https and does not contain any path or query parameters';
        return;
      }
      final data = await ref.read(authControllerProvider.notifier).signIn(userCredentials);
      if (data != null) {
          error.value = data;
      }
    }

    Widget signInButton() => InkWell(
      onTap: signIn,
      borderRadius: BorderRadius.circular(36),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 74),
        decoration: BoxDecoration(
          color: const Color(0xFF404C6C),
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              offset: const Offset(-1, 3),
              color: const Color(0xFF404C6C).withOpacity(0.7),
              spreadRadius: 4,
              blurRadius: 10,
            ),
          ],
        ),
        child: const Text(
          'Sign in',
          style: TextStyle(
            // fontFamily: FontFamily.inter,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const SizedBox(height: 63),
          serverURLField(),
          const SizedBox(height: 8),
          loginField(),
          const SizedBox(height: 8),
          passwordField(),
          const SizedBox(height: 63),
          signInButton(),
        ],
      ),),
    );
  }






}
