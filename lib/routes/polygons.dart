import 'package:flutter/material.dart';
import 'dart:math' as Math;

class PolygonByTrignomentryPage extends StatefulWidget {
  @override
  _PolygonByTrignomentryPageState createState() => _PolygonByTrignomentryPageState();
}

class _PolygonByTrignomentryPageState extends State<PolygonByTrignomentryPage> {
  double _value = 10.0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: CustomPaint(
          painter: RegularPolygonPainter(
              numberOfSides: _value.round(),
              polygonSize: MediaQuery.of(context).size.height / 3),
          child: Container(
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
      Slider(
        value: _value,
        divisions: 10,
        min: 5.0,
        max: 15.0,
        onChanged: (value) => setState(() => _value = value),
        label: _value.toString(),
      )
    ]);
  }
}

class RegularPolygonPainter extends CustomPainter {
  final int numberOfSides;
  final double polygonSize;

  RegularPolygonPainter(
      {@required this.numberOfSides, @required this.polygonSize});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.redAccent[200];

    double angleOfEachSide = (180 * 2) / numberOfSides;

    Offset center = Offset(size.width / 2, size.height / 2);

    double previousX = center.dx + polygonSize;
    double previousY = center.dy;

    Paint circlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.indigo;

    for (int index = 1; index <= numberOfSides + 1; index++) {
      double angleOfEachSideInRadians =
          (angleOfEachSide * index) * Math.pi / 180;
      double x = Math.cos(angleOfEachSideInRadians) * polygonSize + center.dx;
      double y = Math.sin(angleOfEachSideInRadians) * polygonSize + center.dy;

      Path path = Path()
        ..moveTo(previousX, previousY)
        ..lineTo(x, y)
        ..close();

      canvas.drawPath(path, paint);

      Path pathCenterToCorner = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(x, y)
        ..close();

      canvas.drawPath(pathCenterToCorner, paint);

      canvas.drawCircle(center, polygonSize, circlePaint);

      previousX = x;
      previousY = y;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}