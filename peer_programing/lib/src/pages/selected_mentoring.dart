import 'package:flutter/material.dart';

import 'package:peer_programing/src/pages/detalle.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/widgets/lists/mentoring_listview.dart';

class SelectedMentorings extends StatelessWidget {
  MentoringListView _mentoringListView =
      MentoringListView(onResumeTap: _showMentoringDetail);

  SelectedMentorings({Key key}) : super(key: key);

  static Function _showMentoringDetail(BuildContext context, int mentoringId) =>
      () => showDialog(
          context: context,
          child: Detalle(mentoringId,
              actionButton: new RaisedButton(
                child: Text('Cancelar'),
                color: Colors.red,
                onPressed: () => print("Cancelar oferta!"),
              )));

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Ofertas seleccionadas",
      body: Container(
        child: Column(
          children: <Widget>[
            this._mentoringListView,
          ],
        ),
      ),
    );
  }
}
