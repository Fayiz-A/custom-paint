import 'dart:ui';

import 'package:flutter/material.dart';

class CurvesPage extends StatefulWidget {

  @override
  _CurvesPageState createState() => _CurvesPageState();
}

class _CurvesPageState extends State<CurvesPage> {

  Offset dotPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomPaint(
            painter: CurvePainter(dotPosition: dotPosition),
            child: GestureDetector(
              onTapDown: (TapDownDetails tapDownDetails) => setState(() => dotPosition = tapDownDetails.localPosition),
              child: Container(
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CurvePainter extends CustomPainter {
  final Offset dotPosition;
  CurvePainter({@required this.dotPosition});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    Offset center = Offset(size.width / 2, size.height / 2);

    Offset endPoints1 = Offset(center.dx, 0.0);
    Offset controlPoints1 = Offset(endPoints1.dx - (endPoints1.dx / 4), size.height / 2);
    Offset controlPoints2 = Offset(endPoints1.dx - (endPoints1.dx / 2), size.height / 3);

    Path path = Path()
      ..moveTo(0.0, center.dy - (center.dy/2))
      ..cubicTo(controlPoints1.dx, controlPoints1.dy, controlPoints2.dx, controlPoints2.dy, endPoints1.dx, endPoints1.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
