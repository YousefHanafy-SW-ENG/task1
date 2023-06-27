import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurvePainterPage extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.blueAccent!;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * .60);
    path.quadraticBezierTo(
        0, size.height * .60, size.width * .1565, size.height * .60);
    path.lineTo(size.width * .30, size.height * .60);
    path.quadraticBezierTo(size.width * .69, size.height * .40,
        size.width * .60, size.height * .40);
    path.lineTo(size.width * .70, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}