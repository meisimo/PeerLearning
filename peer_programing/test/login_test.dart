import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peer_programing/src/pages/login_page.dart';

void main() {
  group('Load Registro', (){
    testWidgets('.Shows title', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(title: 'Test', home: Registro(),));
      expect(find.text('Registro'), findsOneWidget);
    });
    testWidgets('.Shows form', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(title: 'Test', home: Registro(),));
      
      expect(find.byType(InputLogin), findsNWidgets(5));

      expect(find.text('Nombre'), findsOneWidget );
      expect(find.text('Correo'), findsOneWidget);
      expect(find.text('Contraseña'), findsOneWidget);
      expect(find.text('Confirmar contraseña'), findsOneWidget);
      expect(find.text('Temas de interes'), findsOneWidget);
    });
  });
  group('Required fields', (){
    
  });
  group('Field format.', (){
    testWidgets('Clave alfanumérica', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(title:'Test', home:Registro()));

      tester.enterText(find.byKey(Key('input-contraseña')), '1234');
    });
  });
}