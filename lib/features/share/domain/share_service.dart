import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  const ShareService();

  static const _targetWidthPx = 1080.0;

  Future<Uint8List> capture(GlobalKey boundaryKey) async {
    final boundary =
        boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage(
      pixelRatio: _targetWidthPx / boundary.size.width,
    );
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();

    return bytes!.buffer.asUint8List();
  }

  Future<void> share(Uint8List png, {Rect? sharePositionOrigin}) async {
    final dir = await getTemporaryDirectory();
    final file = File(
      '${dir.path}/pedali_ride_${DateTime.now().millisecondsSinceEpoch}.png',
    );
    await file.writeAsBytes(png);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'image/png')],
        sharePositionOrigin: sharePositionOrigin,
      ),
    );
  }
}
