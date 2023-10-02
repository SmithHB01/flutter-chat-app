import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/widgets.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Logo( titulo: 'Messenger Chat',),
                _Form(),
                Labels(
                  ruta: 'register',
                  titulo: '¿No tienes cuenta?',
                  subTitulo: 'Crea una ahora!',
                ),
                Text('Terminos y condiciones de uso.', style: TextStyle( fontWeight: FontWeight.w200),)
                
              ],
            ),
          ),
        ),
      )
   );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>( context );

    return Container(
      margin: const EdgeInsets.only( top: 40),
      padding: const EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: [

          CustomInput(
            icon: Icons.mail_outline_outlined,
            placeHolder: 'Email',
            textController: emailController,
            keyboardType: TextInputType.emailAddress,
          ),

          CustomInput(
            icon: Icons.lock_outline_rounded,
            placeHolder: 'Password',
            textController: passController,
            // keyboardType: TextInputType.visiblePassword,
            isPassword: true,
          ),
          

          BotonAzul(
            text: 'Ingresar',
            onPressed: authService.autenticando ? null : () async {
              FocusScope.of(context).unfocus();
              final loginOk = await authService.login( emailController.text.trim(), passController.text.trim() );

              if ( loginOk ) {
                // Navegar a otra pantalla
                if(!mounted) return;
                Navigator.pushReplacementNamed(context, 'usuarios');

              } else {
                // Mostrar alerta
                if(!mounted) return;
                mostrarAlerta(context, 'Login incorrecto', 'Revisar sus credenciales');
              }
            },
          )
        ],
      ),
    );
  }
}

