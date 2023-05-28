import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class circular_danger_indicator extends StatefulWidget {
  final double fraction;
  final double width;
  final double height;
  const circular_danger_indicator({
    Key? key,
    required this.fraction,
    required this.width,
    required this.height,
  }) : super(key: key);
  @override
  _circular_danger_indicatorState createState() =>
      _circular_danger_indicatorState();
}


class _circular_danger_indicatorState extends State<circular_danger_indicator> {
  getColor() {
    int red = (255.0 * widget.fraction).round();
    int green = (255 * (1 - widget.fraction)).round();
    return Color.fromRGBO(red, green, 0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            color: Colors.transparent,
            width: widget.width,
            height: widget.height,
            // child: Container(
            //   // margin: const EdgeInsets.all(10.0),
            //   color: Colors.amber[600],
            //   width: 50,
            //   height: 50,
            child: CircularProgressIndicator(
              value: widget.fraction,
              backgroundColor: Colors.grey[400],
              color: getColor(),
              strokeWidth: 20,
            )
        )
    );
  }


}
