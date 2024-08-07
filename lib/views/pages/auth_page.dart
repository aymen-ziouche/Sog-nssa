import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sognssa/controllers/auth_controllers.dart';
import 'package:sognssa/utils/assets.dart';
import 'package:sognssa/utils/enums.dart';
import 'package:sognssa/views/widgets/main_button.dart';
import 'package:sognssa/views/widgets/main_dialog.dart';
import 'package:sognssa/views/widgets/social_media_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthController model) async {
    try {
      await model.submit();
      if (!mounted) return;
    } catch (e) {
      MainDialog(
              context: context,
              title: 'Error Authentication',
              content: e.toString())
          .showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<AuthController>(
      builder: (_, model, __) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 60.0,
                horizontal: 32.0,
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.authFormType == AuthFormType.login
                            ? 'Login'
                            : 'Register',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 80.0),
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        onChanged: model.updateEmail,
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter your email!' : null,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email!',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter your password!' : null,
                        onChanged: model.updatePassword,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your pasword!',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      if (model.authFormType == AuthFormType.login)
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            child: const Text(
                              'Forgot your password?',
                              style: TextStyle(color: Colors.white70),
                            ),
                            onTap: () {},
                          ),
                        ),
                      const SizedBox(height: 24.0),
                      MainButton(
                        text: model.authFormType == AuthFormType.login
                            ? 'Login'
                            : 'Register',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _submit(model);
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          child: Text(
                              model.authFormType == AuthFormType.login
                                  ? 'Don\'t have an account? Register'
                                  : 'Have an account? Login',
                              style: const TextStyle(color: Colors.white70)),
                          onTap: () {
                            _formKey.currentState!.reset();
                            model.toggleFormType();
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.09),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            model.authFormType == AuthFormType.login
                                ? 'Or Login with'
                                : 'Or Register with',
                            style:
                                Theme.of(context).textTheme.titleMedium!.copyWith(
                                      color: Colors.white,
                                    ),
                          )),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialMediaButton(
                            iconName: AppAssets.facebookIcon,
                            onPress: () {},
                          ),
                          const SizedBox(width: 16.0),
                          SocialMediaButton(
                            iconName: AppAssets.googleIcon,
                            onPress: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
