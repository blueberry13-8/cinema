import 'package:cinema/common/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 350.0,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Авторизация', style: context.textTheme.headlineLarge,),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Логин',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Пароль',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
