import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sognssa/controllers/auth_controllers.dart';
import 'package:sognssa/views/widgets/main_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> _logout(AuthController model, context) async {
    try {
      await model.logout();
      Navigator.pop(context);
    } catch (e) {
      debugPrint('logout error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (_, model, __) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 60.0),
          child: Column(
            children: [
              const Spacer(),
              MainButton(
                  text: 'Log Out',
                  onTap: () {
                    _logout(model, context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
