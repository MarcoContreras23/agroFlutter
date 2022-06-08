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
        const BorderSide(color: Color.fromARGB(255, 10, 140, 3), width: 2.0),
    borderRadius: BorderRadius.circular(30.0),
  );
  final textFormFieldStyleWrong = OutlineInputBorder(
    borderSide:
        const BorderSide(color: Color.fromARGB(255, 17, 90, 126), width: 2.0),
    borderRadius: BorderRadius.circular(30.0),
  );
  var spaceBetween = SizedBox(height: Adapt.hp(1));
  var spaceBetweenWidth = SizedBox(width: Adapt.wp(2));
  final ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(20), vertical: Adapt.px(20)),
      primary: const Color.fromARGB(255, 79, 130, 9),
      textStyle: TextStyle(
          fontSize: Adapt.px(40),
          fontWeight: FontWeight.bold,
          color: Colors.black));
  final ButtonStyle style2 = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
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
        ElevatedButton(
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
        ElevatedButton(
          style: style2,
          child: Text("REGISTRARSE",
              style: TextStyle(
                  fontSize: Adapt.px(22),
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          onPressed: () =>
              {Navigator.pushReplacementNamed(context, '/registro')},
        ),
      ],
    );
  }

  Widget correoInput(context, textFormFieldStyle, textFormFieldStyleWrong) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      maxLength: 50,
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
      maxLength: 50,
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

  Widget alert() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      title: Column(
        children: [
          Container(
            child: Image(
                image: const AssetImage('assets/logos/LogoVacoBlanco.png'),
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.15,
                fit: BoxFit.cover),
            margin: const EdgeInsets.only(bottom: 3),
          ),
          const Center(
              child: Text(
            "Hola",
            style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 197, 254, 37)),
          )),
        ],
      ),
      content: SizedBox(
        height: Adapt.hp(15),
        child: const SingleChildScrollView(
          child: Center(
            child: Text(
              "Correo o calve incorrecta",
              style: TextStyle(color: Colors.black),
              maxLines: 15,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(Adapt.px(10)),
          child: Center(
            child: ElevatedButton(
              style: style,
              child: Text("aceptar",
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0))),
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(height: Adapt.hp(1)),
        Padding(
          padding: EdgeInsets.all(Adapt.px(10)),
          child: Center(
            child: ElevatedButton(
              style: style,
              child: Text("cancear",
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        )
      ],
    );
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
        alert();
      }
    }
  }
}
