import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nothing_pomodoro/glyph/glyph_channel.dart';

void main() {
  group("register and unregister", () {
    test('register', () async {
      final channel = GlyphChannel();
      final result = await channel.registerGlyphs();
      expect(result, true);
    });

    test('unregister', () async {
      final channel = GlyphChannel();
      final result = await channel.unregisterGlyphs();
      expect(result, true);
    });
  });
}