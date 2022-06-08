import 'dart:convert';
import 'package:agro2/database/db.dart';
import 'package:agro2/model/register_login.dart';
import 'package:agro2/responsive/Adapt.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _CreateProduxtsState();
}

String email = "", password = "";
dynamic usuarios;

class _CreateProduxtsState extends State<LoginPage> {
  final formKey22 = GlobalKey<FormState>();
  final textFormFieldStyle = OutlineInputBorder(
    borderSide:
        const BorderSide(color: Color.fromARGB(255, 10, 140, 3)),
    borderRadius: BorderRadius.circular(5),
  );
  final textFormFieldStyleWrong = OutlineInputBorder(
    borderSide:
        const BorderSide(color: Color.fromARGB(255, 17, 90, 126)),
    borderRadius: BorderRadius.circular(5),
  );
  var spaceBetween = SizedBox(height: Adapt.hp(1));
  var spaceBetweenWidth = SizedBox(width: Adapt.wp(2));
  final ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(20), vertical: Adapt.px(20)),
      primary: const Color.fromARGB(255, 79, 130, 9),
      textStyle: TextStyle(
          fontSize: Adapt.px(40),
          fontWeight: FontWeight.bold,
          color: Colors.black));
  final ButtonStyle style2 = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(20), vertical: Adapt.px(20)),
      primary: const Color.fromARGB(255, 34, 127, 151),
      textStyle: TextStyle(
          fontSize: Adapt.px(40),
          fontWeight: FontWeight.bold,
          color: Colors.black));

  @override
  void initState() {
    traerUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _body(context, style, spaceBetween, spaceBetweenWidth, style2),
      ),
    );
  }

  Widget _body(context, style, spaceBetween, spaceBetweenWidth, style2) {
    return Column(
      children: [
        _bodyOne(context, style, spaceBetween, spaceBetweenWidth, style2),
        Flexible(
          flex: 8,
          child: _bodyTwo(context, style, spaceBetweenWidth, style2,
              textFormFieldStyle, textFormFieldStyleWrong),
        ),
        _bodyThree(context, style, spaceBetween, spaceBetweenWidth, style2),
        spaceBetween,
      ],
    );
  }

  Widget _bodyOne(context, style, spaceBetween, spaceBetweenWidth, style2) {
    return Column(children: [
      Wrap(
        children: [
          SizedBox(
            height: Adapt.hp(20),
            child: Column(
              children: [
                FittedBox(
                  child: Image(
                    height: Adapt.hp(13),
                    image: const AssetImage('assets/logo.png'),
                  ),
                ),
                spaceBetween,
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Bienvenido a AgroMarket",
                    style: TextStyle(
                        fontSize: Adapt.px(40),
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Adapt.wp(19),
          )
        ],
      ),
    ]);
  }

  Widget _bodyTwo(context, style, spaceBetweenWidth, style2, textFormFieldStyle,
      textFormFieldStyleWrong) {
    return Container(
      height: 550,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey22,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 80.0),
          child: Column(
            children: [
              correoInput(context, textFormFieldStyle, textFormFieldStyleWrong),
              spaceBetweenWidth,
              spaceBetween,
              spaceBetween,
              spaceBetween,
              passwordInput(
                  context, textFormFieldStyle, textFormFieldStyleWrong),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyThree(context, style, spaceBetween, spaceBetweenWidth, style2) {
    return Column(
      children: [
        SizedBox(
          width: Adapt.wp(65), 
          child: ElevatedButton(
            style: style,
            child: Text("INGRESAR",
                style: TextStyle(
                    fontSize: Adapt.px(22),
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            onPressed: () {
              if (formKey22.currentState!.validate()) {
                setState(() {});
                _loguear();
              } else {
                print("no valido");
              }
            },
          ),
        ),
        spaceBetween,
        spaceBetween,
        SizedBox(
          width: Adapt.wp(65), 
          child: ElevatedButton(
            style: style2,
            child: Text("REGISTRARSE",
                style: TextStyle(
                    fontSize: Adapt.px(22),
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            onPressed: () =>
                {Navigator.pushReplacementNamed(context, '/registro')},
          ),
        ),
      ],
    );
  }

  Widget correoInput(context, textFormFieldStyle, textFormFieldStyleWrong) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: Adapt.px(30), horizontal: Adapt.px(15)),
        enabledBorder: textFormFieldStyle,
        disabledBorder: textFormFieldStyle,
        focusedBorder: textFormFieldStyle,
        errorBorder: textFormFieldStyleWrong,
        focusedErrorBorder: textFormFieldStyleWrong,
        label: const Text(
          "Correo",
          style: TextStyle(color: Colors.black),
        ),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      onChanged: (value) {
        email = value;
      },
      validator: (valor) {
        if (valor == '') {
          return 'El campo es obligatorio *';
        }
      },
    );
  }

  Widget passwordInput(context, textFormFieldStyle, textFormFieldStyleWrong) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: Adapt.px(30), horizontal: Adapt.px(15)),
        enabledBorder: textFormFieldStyle,
        disabledBorder: textFormFieldStyle,
        focusedBorder: textFormFieldStyle,
        errorBorder: textFormFieldStyleWrong,
        focusedErrorBorder: textFormFieldStyleWrong,
        label: const Text(
          "Contraseña",
          style: TextStyle(color: Colors.black),
        ),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      onChanged: (value) {
        password = value;
      },
      validator: (valor) {
        if (valor == '') {
          return 'El campo es obligatorio *';
        }
      },
    );
  }

  void _loguear() {
    if (formKey22.currentState!.validate()) {
      final data = {
        'email': email,
        'password': password,
      };
      setState(() {});
      _queryData(data);
    } else {
      print("no valido");
    }
  }

  void traerUsuarios() async {
    usuarios = await DB.instance.readAllDataUsuarios();
  }

  void _queryData(data) {
    dynamic user2 = jsonEncode(data);
    Map<String, dynamic> user = jsonDecode(user2);
    var dataLogin = Usuarios.fromJson(user);
    for (var i = 0; i < usuarios.length; i++) {
      if (usuarios[i].email == (dataLogin.email) &&
          usuarios[i].password == (dataLogin.password)) {
        Navigator.of(context).pushReplacementNamed('/');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color.fromARGB(255, 231, 231, 233),
              title: const Text(
                "Ups",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1, 0.5),
                      blurRadius: 1.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const [
                    Text(
                      "Correo o clave incorrecta",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "ACEPTAR",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }
}
