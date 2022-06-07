import 'package:agro2/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class BarSearch extends StatefulWidget {
  const BarSearch({Key? key}) : super(key: key);

  @override
  State<BarSearch> createState() => _BarSearchState();
}

String nombreProduct = "";

class _BarSearchState extends State<BarSearch> {
  ///Widget que con el estilo y la funcionalidad de la barra de busqueda
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      height: MediaQuery.of(context).size.height * 0.1,
      child: TypeAheadField<User?>(
        minCharsForSuggestions: 2,
        animationStart: 0.1,
        hideSuggestionsOnKeyboardHide: true,
        textFieldConfiguration: const TextFieldConfiguration(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: "Buscar...",
            hintStyle: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 148, 148, 148),
            ),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.blueAccent,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 148, 148, 148), width: 2.0),
            ),
          ),
        ),
        suggestionsCallback: UserApi.getUserSuggestions,
        itemBuilder: (context, User? suggestion) {
          final user = suggestion!;
          return Container(
            color: Colors.white,
            child: ListTile(
                selectedTileColor: Colors.white,
                textColor: Colors.black,
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://www.alqueria.com.co/sites/default/files/styles/1327_612/public/hamburguesa-con-amigos-y-salsa-de-champinones_0.jpg?h=2dfa7a18&itok=hLxehdIa',
                  ),
                ),
                title: Text(
                  user.name,
                )),
          );
        },
        noItemsFoundBuilder: (context) => Container(
          color: Colors.white,
          height: 40,
          child: const Center(
            child: Text(
              'No se encontraron restaurantes',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
        ),
        onSuggestionSelected: (User? suggestion) {
          final user = suggestion!;
          print("user tiene esto ${user}");
          nombreProduct = user.name;
        },
      ),
    );
  }
}
