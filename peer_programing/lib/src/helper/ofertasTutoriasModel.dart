import 'package:cloud_firestore/cloud_firestore.dart';

class OfertasTutorias {
  final String titulo;
  final String descripcion;
  final String lugar;
  final int precio;

  //OfertasTutorias({this.titulo, this.descripcion, this.lugar, this.precio});
  OfertasTutorias.fromMap(Map<String, dynamic> map)
      : titulo = map['titulo'],
        lugar = map['lugar'],
        precio = map['precio'],
        descripcion = map['Descripcion'];

  OfertasTutorias.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data);
}
