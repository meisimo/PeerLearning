import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';

class CreateForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
    FormState();
}

class FormState extends State<CreateForm> with SingleTickerProviderStateMixin {
  TabController _formTabPageController;
  @override
  void initState() {
    super.initState();
    _formTabPageController =
        TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear publicación'),
        bottom: TabBar(
          controller: _formTabPageController,
          tabs: <Widget>[
            Tab(text: 'Para aprender'),
            Tab(text: 'Para enseñar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _formTabPageController,
        children: <Widget>[_learn(), _teach()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
    );
  }
}

List<String> _items = MentoringCategoryList.all().map( (cat) => cat.name);

Widget _learn() {
  List<String> categoriasEscogidas;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 40),
    child: Form(
      autovalidate: true,
      child: Column(
        children: <Widget>[
          DropdownButtonFormField(
            value: null,
            items: _items.map<DropdownMenuItem<String>>(
              (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String newValue) {
              categoriasEscogidas.add(newValue);
              //chips.chipTitles.add(newValue);
            },
            decoration: const InputDecoration(
              hintText: 'Tematicas',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.description),
              hintText: 'Descripcion',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.monetization_on),
              hintText: 'Tarifa',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.place),
              hintText: 'Lugar',
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _teach() {
  List<String> categoriasEscogidas;
  //ChipRow chips;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 40),
    child: Form(
      autovalidate: true,
      child: Column(
        children: <Widget>[
          //chips.showChipRow(),
          DropdownButtonFormField(
            value: null,
            items: _items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String newValue) {
              categoriasEscogidas.add(newValue);
              //chips.chipTitles.add(newValue);
            },
            decoration: const InputDecoration(
              hintText: 'Tematicas',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.description),
              hintText: 'Descripcion',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.monetization_on),
              hintText: 'Tarifa',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.place),
              hintText: 'Lugar',
            ),
          ),
        ],
      ),
    ),
  );
}
