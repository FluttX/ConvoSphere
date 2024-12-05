import 'package:convo_sphere/feature/authentication/presentation/wigets/custom_button.dart';
import 'package:convo_sphere/feature/authentication/presentation/wigets/rich_text_prompt.dart';
import 'package:convo_sphere/feature/authentication/presentation/wigets/text_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextInputWidget(
                hintText: 'Email',
                icon: Icons.email,
                controller: _emailController,
              ),
              const SizedBox(height: 16.0),
              TextInputWidget(
                hintText: 'Password',
                icon: Icons.lock,
                controller: _passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 25.0),
              CustomButtonWidget(
                text: 'Login',
                onPressed: () {},
              ),
              const SizedBox(height: 20.0),
              RichTextPromptWidget(
                text: 'Don\'t have an account?',
                pressableText: 'Click here to register',
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
