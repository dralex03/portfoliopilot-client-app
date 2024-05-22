import 'package:flutter/cupertino.dart';

import '../../controller/login/sign_in_controller.dart';

class SignInWidget extends StatefulWidget {
  final Color backgroundColor;

  const SignInWidget({super.key, required this.backgroundColor});

  @override
  SignInController createState() => SignInController();
}