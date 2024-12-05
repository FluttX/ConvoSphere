import 'package:convo_sphere/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:convo_sphere/features/authentication/presentation/wigets/custom_button.dart';
import 'package:convo_sphere/features/authentication/presentation/wigets/rich_text_prompt.dart';
import 'package:convo_sphere/features/authentication/presentation/wigets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLoginPressed() {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

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
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return CustomButtonWidget(
                    text: 'Login',
                    onPressed: _onLoginPressed,
                  );
                },
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/messages',
                      ModalRoute.withName('/'),
                    );
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
              ),
              const SizedBox(height: 20.0),
              RichTextPromptWidget(
                text: 'Don\'t have an account?',
                pressableText: 'Click here to register',
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
