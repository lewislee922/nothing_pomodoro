import 'package:flutter/services.dart';

class GlyphChannel {
  final MethodChannel _channel;

  GlyphChannel._()
      : _channel = MethodChannel('glyph', const StandardMethodCodec());

  Future<bool> registerGlyphs() async {
    try {
      final result =
          await _channel.invokeMethod<Map<String, dynamic>>('registerGlyphs');
      
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> unregisterGlyphs() async {
    return await _channel.invokeMethod('unregisterGlyphs');
  }
}

class GlyphDeviceInfo {
  final String model;
  final int glyphLength;

  GlyphDeviceInfo(this.model, this.glyphLength);
}
