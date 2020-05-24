import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';

class NotConnectedCard extends StatefulWidget {
  final Function _tryToReconnect;

  NotConnectedCard({@required tryToReconnect})
      : _tryToReconnect = tryToReconnect;

  @override
  _NotConnectedCard createState() =>
      new _NotConnectedCard(tryToReconnect: _tryToReconnect);
}

class _NotConnectedCard extends State<NotConnectedCard> {
  final Function _tryToReconnect;

  _NotConnectedCard({@required tryToReconnect})
      : _tryToReconnect = tryToReconnect;

  Widget _header() => Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Text(
            ":(",
            style: TextStyle(fontSize: 30),
          ),
        ),
      );

  Widget _descripcion() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          "Lo sentimos, parece que no estás conectado a internet. Por favor revisa tu conección.",
          style: TextStyle(fontSize: 17),
        ),
      );

  Widget _buildDialog(context) => Container(
      width: 300,
      height: 230,
      child: Column(
        children: <Widget>[
          _header(),
          _descripcion(),
          _reconnectButton(context)
        ],
      ));

  Widget _reconnectButton(BuildContext context) => Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: RaisedButton(
            child: Icon(Icons.refresh),
            color: LightColor.purple,
            onPressed: _tryToReconnect,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: _buildDialog(context),
      );
}
