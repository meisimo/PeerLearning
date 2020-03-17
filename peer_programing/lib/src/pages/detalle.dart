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
    return ListView(
      children: <Widget>[
        _detailHeader(),
        _chipRow(),
        _textContainer('Descripcion', true),
        _textContainer('Se dan tutorias en calculo y algebra lineal.', false),
        _textContainer('Tarifa', true),
        _textContainer('2000 \$/hora', false),
        _textContainer('Lugar', true),
        _textContainer('Parque Simon Bolivar', false),
      ],
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
            RaisedButton(
              child: Text('Registrarse'),
              onPressed: () => {},
            )
          ],
        ),
        Divider(
          height: 2,
        ),
      ],
    );
  }

  Widget _chipRow() {
    return Row(
      children: <Widget>[
        Chip(
          label: Text('Algebra'),
        ),
        Chip(
          label: Text('Calculo'),
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
