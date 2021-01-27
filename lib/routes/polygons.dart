import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as Math;

class PolygonByTrignomentryPage extends StatefulWidget {
  @override
  _PolygonByTrignomentryPageState createState() => _PolygonByTrignomentryPageState();
}

class _PolygonByTrignomentryPageState extends State<PolygonByTrignomentryPage> {
  double _value = 10.0;
  Offset dotPosition = Offset.zero;
  int indexWhereClicked = 1;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: CustomPaint(
          painter: RegularPolygonPainter(
                numberOfSides: _value.round(),
                polygonSize: MediaQuery.of(context).size.height / 3, 
                dotPosition: dotPosition, 
                coloredSectorIndex: indexWhereClicked,
              ),
          child: GestureDetector(
              onTap: () => print('Tapped'),
              onTapUp: (TapUpDetails tapUpDetails) => setState(() {
                Offset tapOffset = tapUpDetails.globalPosition;
                dotPosition = tapUpDetails.globalPosition;

                List<Offset> offsetAndTappedOffsetDifferenceList = [];

                for (Offset offset in sectionEndOffsetList) {
                  
                  Offset difference = offset - dotPosition;
                  
                  offsetAndTappedOffsetDifferenceList.add(difference);
                }
                List<Offset> offsetAndTappedOffsetDifferenceUnSortedList = offsetAndTappedOffsetDifferenceList.toList();
                print('unsorted list1 is => $offsetAndTappedOffsetDifferenceUnSortedList');

                  offsetAndTappedOffsetDifferenceList.sort((Offset offset1, Offset offset2) { 
                  if(offset1.dx.abs() == offset2.dx.abs() && offset1.dy.abs() == offset2.dy.abs()) {
                    return 0;
                  } else if(offset1.dx.abs() > offset2.dx.abs() && offset1.dy.abs() > offset2.dy.abs()) {
                    return 1;
                  } else if(offset1.dx.abs() < offset2.dx.abs() && offset1.dy.abs() < offset2.dy.abs()) {
                    return -1;
                  } else if(offset1.dx.abs() > offset2.dx.abs() && offset1.dy.abs() < offset2.dy.abs()) {
                    if((offset1.dx.abs() - offset2.dx.abs()) > (offset2.dy.abs() - offset1.dy.abs())) {
                      return 1;
                    } else {
                      return -1;
                    }
                  } else if(offset1.dx.abs() < offset2.dx.abs() && offset1.dy.abs() > offset2.dy.abs()) {
                    if((offset2.dx.abs() - offset1.dx.abs()) > (offset1.dy.abs() - offset2.dy.abs())) {
                      return -1;
                    } else {
                      return 1;
                    }                 
                 } else {
                   return 0;
                 }
                });
                print('unsorted list is => $offsetAndTappedOffsetDifferenceUnSortedList');
                print('sorted list is : ${offsetAndTappedOffsetDifferenceList}');
                indexWhereClicked = offsetAndTappedOffsetDifferenceUnSortedList.indexOf(offsetAndTappedOffsetDifferenceList[0]);
                print('Index where clicked: $indexWhereClicked');
              }),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent
              ),
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

List<Offset> sectionEndOffsetList = [];

class RegularPolygonPainter extends CustomPainter {
  final int numberOfSides;
  final double polygonSize;
  final Offset dotPosition;
  final int coloredSectorIndex;

  RegularPolygonPainter(
      {@required this.numberOfSides, @required this.polygonSize, @required this.dotPosition, @required this.coloredSectorIndex});
  
  @override
  void paint(Canvas canvas, Size size) {

    double angleOfEachSide = (180 * 2) / numberOfSides;

    Offset center = Offset(size.width / 2, size.height / 2);

    double previousX = center.dx + polygonSize;
    double previousY = center.dy;

    Paint circlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.indigo;

    sectionEndOffsetList = [];
    for (int index = 1; index <= numberOfSides + 1; index++) {
        Paint paint = Paint()
          ..style = index == coloredSectorIndex+1 ? PaintingStyle.fill:PaintingStyle.stroke
          ..strokeWidth = 5
          ..strokeJoin = StrokeJoin.round
          ..color = Colors.redAccent[200];

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
      
      sectionEndOffsetList.add(Offset(x, y));

      canvas.drawPath(pathCenterToCorner, paint);

      canvas.drawCircle(center, polygonSize, circlePaint);

      previousX = x;
      previousY = y;
    }

    Paint pointPaint = Paint();
    pointPaint.style = PaintingStyle.fill;
    pointPaint.color = Colors.amber;
    
    canvas.drawCircle(dotPosition, 5, pointPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}