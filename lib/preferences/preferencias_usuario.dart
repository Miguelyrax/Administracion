import 'package:shared_preferences/shared_preferences.dart';
class PreferenciasUsuario {

  //Patron singleton
  static final PreferenciasUsuario _instancias = new PreferenciasUsuario._internal();
 
  factory PreferenciasUsuario(){
    return _instancias;
  }


  PreferenciasUsuario._internal();
  
  SharedPreferences _prefs;

  initPrefs()async{
     this._prefs = await SharedPreferences.getInstance();
  }

  //Ninguna de estas propiedades se usa
  // bool _colorSecundario;
  // int _genero;
  // String _nombre;


  get token {
    return _prefs.getString('token') ?? '';
  }
  set token(String value){
    _prefs.setString('token', value);
  }
  //GET y SET del color secundario
  get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? false;
  }
  set colorSecundario(bool value){
    _prefs.setBool('colorSecundario', value);
  }
  //GET y SET del nombre
  get nombreUsuario {
    return _prefs.getString('nombreUsuario') ?? '';
  }
  set nombreUsuario(String value){
    _prefs.setString('nombreUsuario', value);
  }
  //GET y SET de la última pagina
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'home';
  }
  set ultimaPagina(String value){
    _prefs.setString('ultimaPagina', value);
  }



}
