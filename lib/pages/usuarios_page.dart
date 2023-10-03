import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/services/services.dart';
import 'package:chat_app/models/usuario.dart';


class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  final usuarioService = UsuariosService();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<Usuario> usuarios = [];

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    final socketService = Provider.of<SocketService>( context );

    return Scaffold(
      appBar: AppBar(
        title: Text( usuario.nombre, style: const TextStyle( color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            // Desconectar cliente
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();

          },
          icon: const Icon( Icons.exit_to_app_outlined, color: Colors.black54,)
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only( right: 10),
            child: ( socketService.socket.connected ) //socketService.serverStatus == ServerStatus.Online
              ? const Icon( Icons.check_circle, color: Colors.blueAccent )
              : const Icon( Icons.offline_bolt_sharp, color: Colors.redAccent ),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon( Icons.check, color: Colors.blue.shade400 ),
          waterDropColor: Colors.blue.shade400,
        ),
        child: _listViewUsuarios(),
      )
   );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: ( _, i ) => _usuarioListTile( usuarios[i]),
      separatorBuilder: ( _, i) => const Divider(),
      itemCount: usuarios.length
    );
  }

  ListTile _usuarioListTile( Usuario usuario) {
    return ListTile(
        title: Text( usuario.nombre),
        subtitle: Text( usuario.email),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text( usuario.nombre.substring(0,2)),
        ),

        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.greenAccent : Colors.redAccent,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: () {

         final chatService = Provider.of<ChatService>(context, listen: false);
         chatService.usuarioPara = usuario;
         Navigator.pushNamed(context, 'chat');
        },
      );
  }

  _cargarUsuarios() async {

    usuarios = await usuarioService.getUsuarios();
    setState(() {});
  //  await Future.delayed( const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

  }

}