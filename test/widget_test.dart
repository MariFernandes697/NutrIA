import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart'; // ajuste o nome do pacote se for diferente

void main() {
  testWidgets('App inicializa corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(const NutriAApp());

    expect(find.text('NutriA'), findsOneWidget);
  });
}
