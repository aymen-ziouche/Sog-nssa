import 'package:flutter/material.dart';
import 'package:sognssa/utils/enums.dart';
import 'package:sognssa/views/widgets/main_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _authType = AuthFormType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 32.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_authType == AuthFormType.login ? 'Login' : 'Register',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
              const SizedBox(height: 100),
              TextFormField(
                controller: _emailController,
                validator: (val) => val!.isEmpty ? 'Email is required' : null,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // password field
              TextFormField(
                controller: _passwordController,
                validator: (val) =>
                    val!.isEmpty ? 'Password is required' : null,
                decoration: InputDecoration(
                  labelText: 'password',
                  hintText: 'Enter your password',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (_authType == AuthFormType.login)
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: const Text(
                      'Forgot your password?',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {},
                  ),
                ),
              const SizedBox(height: 24),
              MainButton(
                  text: _authType == AuthFormType.login ? 'Login' : 'Register',
                  onTap: () {}),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  child: Text(
                      _authType == AuthFormType.login
                          ? 'Don\'t have an account? Register'
                          : 'Have an account? Login',
                      style: const TextStyle(color: Colors.white)),
                  onTap: () {
                    setState(() {
                      if (_authType == AuthFormType.login) {
                        _authType = AuthFormType.register;
                      } else {
                        _authType = AuthFormType.login;
                      }
                    });
                  },
                ),
              ),
              const Spacer(),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    _authType == AuthFormType.login
                        ? 'Or Login with'
                        : 'Or Register with',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: Colors.white,
                        ),
                  )),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 16.0),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
