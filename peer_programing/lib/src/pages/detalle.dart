import 'package:flutter/material.dart';

class Detalle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetalleState();
  }
}

class DetalleState extends State<Detalle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _detailHeader(),
          _chipRow(),
          Divider(
            height: 2,
          ),
          _textContainer('Descripcion:', true),
          _textContainer(
              '\nSe dan tutorias en calculo y algebra lineal.', false),
          Divider(
            height: 2,
          ),
          _textContainer('Tarifa:', true),
          _textContainer('\n2000 \$/hora', false),
          Divider(
            height: 2,
          ),
          _textContainer('Lugar:', true),
          _textContainer('\nParque Simon Bolivar', false),
          Divider(
            height: 2,
          ),
        ],
      ),
    );
  }

  Widget _detailHeader() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Juan Erich'),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.star),
            Icon(Icons.star),
            Icon(Icons.star),
            Icon(Icons.star),
            Icon(Icons.star_half),
            Spacer(),
            RaisedButton(
              child: Text('Registrarse'),
              color: Colors.green,
              onPressed: () => { }
            )
          ],
        ),
      ],
    );
  }

  Widget _chipRow() {
    return Row(
      children: <Widget>[
        Chip(
          label: Text(
            'Algebra',
            style: TextStyle(color: Colors.red[400]),
          ),
          backgroundColor: Colors.pink[50],
        ),
        Chip(
          label: Text(
            'Calculo',
            style: TextStyle(color: Colors.blue[400]),
          ),
          backgroundColor: Colors.lightBlue[50],
        ),
      ],
    );
  }

  Widget _textContainer(text, big) {
    if (big) {
      return Container(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 30),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          textAlign: TextAlign.left,
        ),
      );
    }
  }
}
