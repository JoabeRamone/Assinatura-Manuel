import 'package:assinatura_manuel/CustomPainter/touch_points.dart';
import 'package:flutter/cupertino.dart';

import 'dart:ui' as ui;

class MyPainter extends CustomPainter {
  MyPainter({this.pointsList});

  List<TouchPoints> pointsList;
  List<Offset> offsetPoints = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        // Desenhar linha quando dois pontos consecutivos estiverem disponíveis
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points, pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));

        //Desenhe pontos quando dois pontos não estiverem próximos um do outro
        canvas.drawPoints(ui.PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
}

