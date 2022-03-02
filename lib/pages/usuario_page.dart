import 'package:administracion/model/usuario_model.dart';
import 'package:administracion/services/usuarios_service.dart';
import 'package:administracion/widgets/alert.dart';
import 'package:administracion/widgets/headers.dart';
import 'package:administracion/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsuarioPage extends StatefulWidget {

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  final nombreController = TextEditingController();
  final passwordController = TextEditingController();
  final usuarioController = TextEditingController();
  final emailController = TextEditingController();
  final usuariosServices = UsuarioService();
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<Usuario> usuarios = [];
  UsuarioService usuarioService;
  @override
    void initState() {
      this.usuarioService = Provider.of<UsuarioService>(context,listen: false);
      this.usuarios = usuarioService.usuarios;
      super.initState();
    }
    

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
         
          Container(
            margin: EdgeInsets.only(top: 300),
            child: SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              header: WaterDropHeader(
              complete: Icon(Icons.check, color: Color(0xffA3CB38),),
              waterDropColor: Color(0xffA3CB38),
              ),
              onRefresh: _getUsuarios,
              child: ListView.builder(            
                physics: BouncingScrollPhysics(),
                itemBuilder:(_,i)=> GestureDetector(onDoubleTap: ()=>_editarUser(usuarios[i]),child: UserCard(user: usuarios[i])),
                itemCount: usuarios.length,
            
              ),
            ),
          ),
          Header(
                      color2:Color(0xffA3CB38) , titulo: 'Usuarios', color1:Color(0xff009432) , icono: FontAwesomeIcons.user,
              ),
      
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffA3CB38),
        child: FaIcon(FontAwesomeIcons.plus),
        onPressed: (){
          nombreController.text=''; passwordController.text=''; usuarioController.text=''; emailController.text='';
          alert(context,nombreController, passwordController, usuarioController ,emailController, _getUsuarios,false, null);
        },
      ),
   );
  }
  void _getUsuarios()async{
  this.usuarios =  await usuariosServices.getUsuarios();
  setState(() {
      
    });
    _refreshController.refreshCompleted();
}

  void _editarUser(Usuario user) {
    nombreController.text = user.nombre;
    passwordController.text = user.password;
    usuarioController.text = user.nombre;
    emailController.text = user.email;
    setState(() {
      alert(context,nombreController, passwordController, usuarioController ,emailController, _getUsuarios,true, user.id);
    });


  }

}


