import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario.internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario.internal();

  late SharedPreferences _prefs;

  iniciarPreferencias() async {
    _prefs = await SharedPreferences.getInstance();
  }

  limpiar() async {
    _prefs.clear();
  }

  String get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String valor) {
    _prefs.setString('token', valor);
  }

  String get usuario {
    return _prefs.getString('usuario') ?? '';
  }

  set usuario(String valor) {
    _prefs.setString('usuario', valor);
  }

  String get password {
    return _prefs.getString('password') ?? '';
  }

  set password(String valor) {
    _prefs.setString('password', valor);
  }

  String get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String valor) {
    _prefs.setString('email', valor);
  }

  String get alergia {
    return _prefs.getString('alergia') ?? '';
  }

  set alergia(String valor) {
    _prefs.setString('alergia', valor);
  }

  String get idMunicipioCliente {
    return _prefs.getString('idMunicipio') ?? '';
  }

  set idMunicipioCliente(String valor) {
    _prefs.setString('idMunicipio', valor);
  }

  bool get check {
    return _prefs.getBool('check') ?? false;
  }

  set check(bool valor) {
    _prefs.setBool('check', valor);
  }

  String get pantalla {
    return _prefs.getString('pantalla') ?? '';
  }

  set pantalla(String valor) {
    _prefs.setString('pantalla', valor);
  }

  List<String> get restaurantFavorite {
    return _prefs.getStringList('restaurantFavorite') ?? [];
  }

  set restaurantFavorite(List<String> valor) {
    _prefs.setStringList('restaurantFavorite', valor);
  }

  String get nombreRestaurante {
    return _prefs.getString('nombreRestaurante') ?? '';
  }

  set nombreRestaurante(String valor) {
    _prefs.setString('nombreRestaurante', valor);
  }

  String get idOrden {
    return _prefs.getString('idOrden') ?? '0';
  }

  set idOrden(String valor) {
    _prefs.setString('idOrden', valor);
  }
}
