import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/services/services.dart';
import 'package:chat_app/pages/pages.dart';


class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: Text('Por favor espere...'),
           ); 
        },
      ),
   );
  }

  Future checkLoginState( BuildContext context ) async {

    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>( context, listen: false );
    final autenticado = await authService.isLoggedIn();

    if ( autenticado ) {
      
      socketService.connect();
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___) => const UsuariosPage(),
          transitionDuration: const Duration( milliseconds: 0 ),
        ),
      );
    } else {

      if (!context.mounted) return;
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___) => const LoginPage(),
          transitionDuration: const Duration( milliseconds: 0 ),
        ),
      );
    }

  }

}