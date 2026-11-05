import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog_01/main.dart';

void main() {
  testWidgets('Mini Katalog ana ekranı açılır', (WidgetTester tester) async {
    await tester.pumpWidget(const MiniKatalogApp());

    expect(find.text('Teknoloji seçkisi'), findsOneWidget);
    expect(find.text('Öne çıkan ürünler'), findsOneWidget);
  });
}