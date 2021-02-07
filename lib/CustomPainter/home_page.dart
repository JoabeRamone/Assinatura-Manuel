import 'dart:typed_data';

import 'package:assinatura_manuel/CustomPainter/touch_points.dart';
import 'package:assinatura_manuel/CustomPainter/visualizar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'my_painter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey globalKey = GlobalKey();

  List<TouchPoints> points = [];
  StrokeCap strokeType = StrokeCap.round;
  double strokeWidth = 3.0;
  Color selectedColor = Colors.black;
  double opacity = 1.0;

  void _visualizar(context) async {
    RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Visualizar(pngBytes)));
  }

  TouchPoints _criarTouchPoints(renderBox, details) {
    return TouchPoints(
        points: renderBox.globalToLocal(details.globalPosition),
        paint: Paint()
          ..strokeCap = strokeType
          ..isAntiAlias = true
          ..color = selectedColor.withOpacity(opacity)
          ..strokeWidth = strokeWidth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            points.add(_criarTouchPoints(renderBox, details));
          });
        },
        onPanStart: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            points.add(_criarTouchPoints(renderBox, details));
          });
        },
        onPanEnd: (details) {
          setState(() {
            points.add(null);
          });
        },
        child: RepaintBoundary(
          key: globalKey,
          child: CustomPaint(
            size: Size.infinite,
            painter: MyPainter(pointsList: points),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upload_rounded),
        onPressed: () {
          setState(() {
            _visualizar(context);
          });
        },
      ),
    );
  }
}
