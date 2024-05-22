import 'package:flutter/cupertino.dart';

import '../../controller/login/register_controller.dart';

class RegisterWidget extends StatefulWidget {
  final Color backgroundColor;

  const RegisterWidget({super.key, required this.backgroundColor});

  @override
  RegisterController createState() => RegisterController();
}