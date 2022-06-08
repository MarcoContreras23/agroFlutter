import 'dart:convert';
import 'package:agro2/database/db.dart';
import 'package:agro2/model/register_login.dart';
import 'package:agro2/responsive/Adapt.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

String name = "", email = "", document = "", phone = "", password = "";

/**
 * Esta clase es la que se encarga de manejar el registro de usuarios
 * donde se encuetran los diferentes campos de texto para ingresar los datos
 * del usuario, para realizar su registro
 */
class _RegisterPageState extends State<RegisterPage> {
  final formKey22 = GlobalKey<FormState>();
  final textFormFieldStyle = OutlineInputBorder(
    borderSide: const BorderSide(color: Color.fromARGB(255, 2, 119, 189)),
    borderRadius: BorderRadius.circular(5),
  );
  final textFormFieldStyleWrong = OutlineInputBorder(
    borderSide: const BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
    borderRadius: BorderRadius.circular(5),
  );
  var spaceBetween = SizedBox(height: Adapt.hp(1));
  var spaceBetweenWidth = SizedBox(width: Adapt.wp(2));
  final ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(20), vertical: Adapt.px(10)),
      primary: Color.fromARGB(255, 79, 130, 9),
      textStyle: TextStyle(
          fontSize: Adapt.px(30),
          fontWeight: FontWeight.bold,
          color: Colors.black));
  final ButtonStyle style2 = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.symmetric(
          horizontal: Adapt.px(20), vertical: Adapt.px(10)),
      primary: const Color.fromARGB(255, 254, 37, 37),
      textStyle: TextStyle(
          fontSize: Adapt.px(30),
          fontWeight: FontWeight.bold,
          color: Colors.black));

/**
 * Widget encargado de construir el cuerpo de la vista
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: _body(context, style, spaceBetween, spaceBetweenWidth, style2),
        ));
  }

/**
 *  Widget contenedor de los diferentes elementos de la vista
 * que se encuentra divido en 3 apartados 
 * (Titulo o encabezado, inputs para formulario, 
 * botones con funcionalidades implementadas)
 */
  Widget _body(context, style, spaceBetween, spaceBetweenWidth, style2) {
    return Container(
      child: Column(
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
      ),
    );
  }

/**
   * Widget encargado de construir el primer apartado de la vista
   * contiene la imagen de la aplicacion y el titulo de la misma
   */
  Widget _bodyOne(context, style, spaceBetween, spaceBetweenWidth, style2) {
    return Column(children: [
      Wrap(
        children: [
          Padding(
            padding: EdgeInsets.only(left: Adapt.px(20), top: Adapt.px(60)),
            child: bottonBack(),
          ),
          Container(
            height: Adapt.hp(20),
            child: Column(
              children: [
                FittedBox(
                  child: Image(
                    height: Adapt.hp(13),
                    image: const AssetImage('assets/logo.png'),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Registro de usuarios",
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

/**
 * Widget encargado de construir el segundo apartado de la vista
 * Contiene los diferentes inputs que se manejan para la solicitud de la información
 */
  Widget _bodyTwo(context, style, spaceBetweenWidth, style2, textFormFieldStyle,
      textFormFieldStyleWrong) {
    return Container(
      height: 550,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey22,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: [
              nombreInput(context, textFormFieldStyle, textFormFieldStyleWrong),
              spaceBetween,
              correoInput(context, textFormFieldStyle, textFormFieldStyleWrong),
              spaceBetween,
              documentoInput(
                  context, textFormFieldStyle, textFormFieldStyleWrong),
              spaceBetween,
              celularInput(
                  context, textFormFieldStyle, textFormFieldStyleWrong),
              spaceBetween,
              passwordInput(
                  context, textFormFieldStyle, textFormFieldStyleWrong),
            ],
          ),
        ),
      ),
    );
  }

/**
   * Widget encargado de construir el tercer apartado de la vista
   * Contiene los botones de acciones que permiten realizar las diferentes solicitudes
   * al presionar el boton REGISTRARSE, se guarda la infomación en la base de datos
   */
  Widget _bodyThree(context, style, spaceBetween, spaceBetweenWidth, style2) {
    return Column(
      children: [
        Wrap(
          children: [
            SizedBox(
              width: Adapt.wp(35),
              child: ElevatedButton(
                style: style,
                child: Text("REGISTRARSE",
                    style: TextStyle(
                        fontSize: Adapt.px(22),
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () {
                  if (formKey22.currentState!.validate()) {
                    setState(() {});
                    _crear();
                  } else {
                    print("no valido");
                  }
                },
              ),
            ),
            SizedBox(width: Adapt.wp(5)),
            SizedBox(
              width: Adapt.wp(35),
              child: ElevatedButton(
                style: style2,
                child: Text("CANCELAR",
                    style: TextStyle(
                        fontSize: Adapt.px(22),
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () =>
                    {Navigator.pushReplacementNamed(context, '/landing')},
              ),
            ),
          ],
        ),
      ],
    );
  }

/**
 * Widget encargado de construir el boton de retroceso
 */
  Widget bottonBack() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        padding: EdgeInsets.symmetric(
            horizontal: Adapt.px(15), vertical: Adapt.px(22)),
        primary: const Color.fromARGB(255, 2, 119, 189),
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/login');
      },
      child: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: Adapt.px(35),
      ),
    );
  }

/**
   * Widget encargado de construir el input de nombre
   * con sus respectivas configuraciones visuales y funcionalidades
   */
  Widget nombreInput(context, textFormFieldStyle, textFormFieldStyleWrong) {
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
          "Nombre",
          style: TextStyle(color: Colors.black),
        ),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      onChanged: (value) {
        name = value;
      },
      validator: (valor) {
        if (valor == '') {
          return 'El campo es obligatorio *';
        }
      },
    );
  }

  /**
   * Widget encargado de construir el input de correo
   * con sus respectivas configuraciones visuales y funcionalidades
   */
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

  /**
   * Widget encargado de construir el input de documento
   * con sus respectivas configuraciones visuales y funcionalidades
   */
  Widget documentoInput(context, textFormFieldStyle, textFormFieldStyleWrong) {
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
          "Número de documento",
          style: TextStyle(color: Colors.black),
        ),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      onChanged: (value) {
        document = value;
      },
      validator: (valor) {
        if (valor == '') {
          return 'El campo es obligatorio *';
        }
      },
    );
  }

  /**
   * Widget encargado de construir el input de contraseña
   * con sus respectivas configuraciones visuales y funcionalidades
   */
  Widget celularInput(context, textFormFieldStyle, textFormFieldStyleWrong) {
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
          "Celular",
          style: TextStyle(color: Colors.black),
        ),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      onChanged: (value) {
        phone = value;
      },
      validator: (valor) {
        if (valor == '') {
          return 'El campo es obligatorio *';
        }
      },
    );
  }

  /**
   * Widget encargado de construir el input de contraseña
   * con sus respectivas configuraciones visuales y funcionalidades
   */
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

  void _crear() {
    if (formKey22.currentState!.validate()) {
      final data = {
        'name': name,
        'email': email,
        'document': document,
        'phone': phone,
        'password': password,
      };
      setState(() {});
      _queryData(data);
    } else {
      print("no valido");
    }
  }

  void _queryData(data) {
    dynamic user2 = jsonEncode(data);
    Map<String, dynamic> user = jsonDecode(user2);
    var dataRegister = Usuarios.fromJson(user);
    DB.instance.insertDataUsuarios(dataRegister);
  }
}
