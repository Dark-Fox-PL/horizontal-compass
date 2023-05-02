import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizontal_compass/horizontal_compass.dart';

void main() {
  group('Horizontal Compass Widget', () {
    test('is a valid instance', () {
      const widget = HorizontalCompass(value: 10, segments: {}, colors: []);
      expect(widget, isA<HorizontalCompass>());
    });

    test('is a stateful widget', () {
      const widget = HorizontalCompass(value: 10, segments: {}, colors: []);
      expect(widget, isA<StatefulWidget>());
    });
  });
}