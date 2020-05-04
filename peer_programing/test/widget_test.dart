import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyWidget extends StatelessWidget {
  final String title;
  final String message;

  const MyWidget({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}

void main() {
  group("Test", (){
    testWidgets('.Counter increments smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));
      expect(find.text('T'), findsOneWidget);
      expect(find.text('M'), findsOneWidget);

    });
    testWidgets('.Counter key', (WidgetTester tester) async {
      final testKey = Key('test');
      await tester.pumpWidget(MyWidget(key: testKey, title: 'T', message: 'M'));
      expect(find.byKey(testKey), findsOneWidget);
    });
  });
}
