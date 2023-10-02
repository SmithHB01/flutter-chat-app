import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/widgets/widgets.dart';
import 'package:chat_app/services/auth_service.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});


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
                
                Logo( titulo: 'Register',),
                _Form(),
                Labels(
                  ruta: 'login',
                  titulo: '¿Ya tienes una cuenta?',
                  subTitulo: 'Ingresas ahora!',
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

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only( top: 40),
      padding: const EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: [

          CustomInput(
            icon: Icons.perm_identity_outlined,
            placeHolder: 'Name',
            textController: nameController,
            keyboardType: TextInputType.text,
          ),

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
            text: 'Crear cuenta',
            onPressed: authService.autenticando ? null : () async {

              final registroOk = await authService.register(nameController.text.trim(), emailController.text.trim(), passController.text.trim() );

              if ( registroOk == true ) {

                if (!mounted) return;
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {

                if (!mounted) return;
                mostrarAlerta(context, 'Registro incorrecto', registroOk);
              }
     
            },
          )
        ],
      ),
    );
  }
}

