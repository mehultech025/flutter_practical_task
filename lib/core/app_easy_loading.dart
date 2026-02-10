/// used to show loading, error alerts.

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'dart:math';

import 'app_colors.dart' show purple8D15FFColor;
easyLoadingShowProgress({
  String? status,
  Widget? indicator,
  EasyLoadingMaskType? maskType = EasyLoadingMaskType.clear,
  bool? dismissOnTap,
  bool withDismiss = true
}){
  easyLoadingDismiss(withDismiss: withDismiss);
  EasyLoading.instance
    ..displayDuration =const Duration(milliseconds: 2000)
    ..loadingStyle =EasyLoadingStyle.custom //This was missing in earlier code
    ..backgroundColor = purple8D15FFColor
    ..indicatorColor = Colors.white
    ..maskColor = purple8D15FFColor
  // ..textStyle = TextStyle(color: Colors.white,fontFamily: ralewayFont,fontWeight: semiBold)
    ..textColor=Colors.white

  // ..boxShadow=[ BoxShadow(
  //   color: Colors.black.withOpacity(0.1),
  //   offset: Offset(0, 2),
  //   blurRadius: 3,
  //   spreadRadius: 5,
  // ),]
    ..dismissOnTap = false;

  EasyLoading.show(status: status, indicator: indicator, maskType: maskType,dismissOnTap: dismissOnTap,);
}

easyLoadingShowError( String status, {
  Duration? duration,
  EasyLoadingMaskType? maskType,
  bool? dismissOnTap,
  bool withDismiss = true
}){
  easyLoadingDismiss(withDismiss: withDismiss);
  EasyLoading.instance
    ..displayDuration =const Duration(milliseconds: 2000)
    ..loadingStyle =EasyLoadingStyle.custom //This was missing in earlier code
    ..backgroundColor = purple8D15FFColor
    ..indicatorColor = Colors.white
    ..maskColor = purple8D15FFColor
  // ..textStyle = TextStyle(color: Colors.white,fontFamily: ralewayFont,fontSize: 20)
    ..dismissOnTap = false;
  EasyLoading.showError(status,duration: duration, maskType: maskType, dismissOnTap: dismissOnTap);
}

easyLoadingShowSuccess( String status, {
  Duration? duration,
  EasyLoadingMaskType? maskType,
  bool? dismissOnTap,
  bool withDismiss = true
}){
  easyLoadingDismiss(withDismiss: withDismiss);
  EasyLoading.instance
    ..displayDuration =const Duration(milliseconds: 2000)
    ..loadingStyle =EasyLoadingStyle.custom //This was missing in earlier code
    ..backgroundColor = purple8D15FFColor
    ..indicatorColor = Colors.white
    ..maskColor = purple8D15FFColor
  // ..textStyle = TextStyle(color: Colors.white,fontFamily: ralewayFont)
    ..dismissOnTap = false;
  EasyLoading.showSuccess(status,duration: duration, maskType: maskType, dismissOnTap: dismissOnTap);
}

easyLoadingDismiss({bool withDismiss = true}){
  if(withDismiss) {
    EasyLoading.dismiss();
  }
}

Widget loadingWidget({Color? color,double? size}) {
  return Container(
      height: size ?? 36.0,
      width: size ?? 36.0,
      alignment: Alignment.center,
      //  child: CircularProgressIndicator(color: color??Colors.white,strokeWidth: size !=null&&size<30?2:null,));
      child: GradientLoader(size: size,));
  //   SpinKitFadingCircle(
  //   color: color??Colors.white,
  //   size: size??35.0,
  // );
}
class GradientLoader extends StatefulWidget {
  final Color? color;
  final double? size;
  const GradientLoader({Key? key,this.color,this.size}) : super(key: key);

  @override
  _GradientLoaderState createState() => _GradientLoaderState();
}

class _GradientLoaderState extends State<GradientLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: Duration(seconds: 1))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * pi,
              child: CustomPaint(
                size: widget.size!=null?Size(widget.size!, widget.size!):Size(36, 36),
                painter: _ArcPainter(widget.size),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double? strokeSize;
  _ArcPainter(this.strokeSize);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = strokeSize!=null && strokeSize!<30?3.0:4.0;
    final rect = Offset.zero & size;

    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: pi * 2,
      stops: [0.0, 0.5, 1.0],
      colors: [
        Colors.black.withOpacity(0.1), // shadow-like faint white
        Colors.grey.shade400,
        Colors.white, // brighter end
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      0,
      2 * pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}


