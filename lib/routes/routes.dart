import 'package:flutter/material.dart';

import 'package:chat_app/pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

  'usuarios': ( _ ) => const UsuariosPage(),
  'caht': ( _ ) => const ChatPage(),
  'login': ( _ ) => const LoginPage(),
  'register': ( _ ) => const RegisterPage(),
  'loading': ( _ ) => const LoadingPage(),


};