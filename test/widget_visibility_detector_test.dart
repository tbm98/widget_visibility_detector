import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:widget_visibility_detector/widget_visibility_detector.dart';

void main() {
  VisibilityDetectorController.instance.updateInterval = Duration.zero;

  testWidgets('adds one to input values', (tester) async {
    int appear = 0;
    int disappear = 0;
    int appear2 = 0;
    int disappear2 = 0;

    Widget _page2() {
      return WidgetVisibilityDetector(onAppear: () {
        appear2++;
      }, onDisappear: () {
        disappear2++;
      }, child: Center(
        child: Builder(
          builder: (context) {
            return TextButton(
              child: const Text('back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ));
    }

    Widget _page1() {
      return WidgetVisibilityDetector(onAppear: () {
        appear++;
      }, onDisappear: () {
        disappear++;
      }, child: Scaffold(body: Center(child: Builder(
        builder: (context) {
          return TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return _page2();
              }));
            },
            child: const Text('click'),
          );
        },
      ))));
    }


    await tester.pumpWidget(MaterialApp(
      home: _page1(),
    ));
    expect(appear, 1);
    expect(disappear, 0);
    expect(appear2, 0);
    expect(disappear2, 0);

    await tester.tap(find.text('click'));
    await tester.pumpAndSettle();
    expect(appear, 1);
    expect(disappear, 1);
    expect(appear2, 1);
    expect(disappear2, 0);

    await tester.tap(find.text('back'));
    await tester.pumpAndSettle();
    expect(appear, 2);
    expect(disappear, 1);
    expect(appear2, 1);
    expect(disappear2, 1);

    // expect(appear, 1);
    // expect(disappear, 0);
  });
}
