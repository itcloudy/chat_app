import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'dart:math';

const BOX_COLOR = Colors.cyan;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Spring Box",
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          child: PhysicsBox(boxPosition: 0.0),
          padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0,bottom: 20.0),

        ),
      )
    );
  }
}

class PhysicsBox extends StatefulWidget {
  final  boxPosition;
  PhysicsBox({this.boxPosition=0.0});
  @override
  _PhysicsBoxState createState() => _PhysicsBoxState();
}

class _PhysicsBoxState extends State<PhysicsBox> with TickerProviderStateMixin {

  double boxPosition;
  double boxPositionOnStart;
  Offset start;
  Offset point;

  AnimationController controller;
  ScrollSpringSimulation simulation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: startDrag,
      onPanUpdate: onDrag,
      onPanEnd: endDrag,
      child: CustomPaint(
        painter: BoxPainter(
          color: BOX_COLOR,
          boxPosition: boxPosition,
          boxPositionOnStart: boxPositionOnStart ?? boxPosition,
          touchPoint: point,
        ),
        child: Container(

        ),
      ),
    );
  }
  void startDrag(DragStartDetails details){
    start = (context.findRenderObject() as RenderBox)
        .globalToLocal(details.globalPosition);
    boxPositionOnStart = boxPosition;
  }
  void onDrag(DragUpdateDetails details){
    setState(() {
      point = (context.findRenderObject() as RenderBox)
          .globalToLocal(details.globalPosition);
      final dragVec = start.dy - point.dy;
      final normDragVec = (dragVec/context.size.height).clamp(-1.0,1.0);
      boxPosition = (boxPositionOnStart +normDragVec).clamp(0.0, 1.0);
    });
  }
  void endDrag(DragEndDetails details){
    setState(() {
      start = null;
      point = null ;
      boxPositionOnStart = null;
    });
  }
  @override
  void initState() {
    super.initState();
    boxPosition = widget.boxPosition;
    simulation = ScrollSpringSimulation(
        SpringDescription(
          mass: 1.0,
          stiffness: 1.0,
          damping: 1.0,
        ),
        0.0,
        0.0,
        0.0
    );
    controller =AnimationController(vsync: this)
    ..addListener((){
      print('${simulation.x(controller.value)}');
    });
  }

}

class BoxPainter extends CustomPainter{
  final double boxPosition;
  final double boxPositionOnStart;
  final Color color;
  final Offset touchPoint;
  final Paint boxPaint;
  final Paint dropPaint;

  BoxPainter({
    this.boxPosition = 0.0,
    this.boxPositionOnStart = 0.0,
    this.color = Colors.grey,
    this.touchPoint,
  }):boxPaint = Paint(),
  dropPaint = Paint(){
    boxPaint.color = this.color;
    boxPaint.style = PaintingStyle.fill;
    dropPaint.color = Colors.grey;
    dropPaint.style = PaintingStyle.fill;

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    final boxValueY = size.height - (size.height * boxPosition);
    final preBoxValueY = size.height -(size.height * boxPositionOnStart);
    final midPointY = ((boxValueY - preBoxValueY) * 1.2 +preBoxValueY)
    .clamp(0.0, size.height);

    Point left,mid,right;
    left = Point(-100.0, preBoxValueY);
    right = Point(size.width + 50.0, preBoxValueY);
    if (null != touchPoint){
      mid = Point(touchPoint.dx, midPointY);
    }else{
      mid = Point(size.width /2 , midPointY);
    }
    final path = Path();
    path.moveTo(mid.x, mid.y);
    path.quadraticBezierTo(mid.x-100.0, mid.y, left.x, left.y);
    path.lineTo(0.0, size.height);
    path.moveTo(mid.x, mid.y);
    path.quadraticBezierTo(mid.x + 100 , mid.y, right.x, right.y);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    canvas.drawPath(path, boxPaint);
    canvas.drawCircle(Offset(right.x, right.y), 10.0, dropPaint);
  }


}