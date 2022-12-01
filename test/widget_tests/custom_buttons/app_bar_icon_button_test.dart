import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:epicmobile/utilities/theme/light_colors.dart';
import 'package:epicmobile/utilities/theme/stack_colors.dart';
import 'package:epicmobile/widgets/custom_buttons/app_bar_icon_button.dart';

void main() {
  testWidgets("AppBarIconButton test", (tester) async {
    int buttonPressedCount = 0;
    final button = AppBarIconButton(
      icon: const Icon(Icons.print),
      onPressed: () => buttonPressedCount++,
      shadows: const [
        BoxShadow(
          color: Colors.green,
          spreadRadius: 1.0,
          blurRadius: 2.0,
        )
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: [
            StackColors.fromStackColorTheme(LightColors()),
          ],
        ),
        home: Material(
          child: button,
        ),
      ),
    );

    expect(find.byIcon(Icons.print), findsOneWidget);

    await tester.tap(find.byType(AppBarIconButton));
    await tester.pumpAndSettle();

    expect(buttonPressedCount, 1);
  });
}
