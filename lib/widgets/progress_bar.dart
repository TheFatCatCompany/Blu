import 'package:flutter/material.dart';


class ProgressBar extends StatefulWidget {
  final double width;
  final double height;
  final double fraction;
  const ProgressBar({Key? key,
    required this.width,
    required this.height,
    required this.fraction,
  }) : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  // double red = 255.0 * widget.fraction;
  // int green = 255 * (1-widget.fraction);
  int red = 0;
  int blue = 0;

  @override
  void initState() {
    super.initState();
    red = (255.0 * widget.fraction).round();
    blue = (255 * (1-widget.fraction)).round();
    print(red);

  }

  Color getColor(){
    red = (255.0 * widget.fraction).round();
    blue = (255 * (1-widget.fraction)).round();
    return Color.fromRGBO(red, 0, blue, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return Center(
        child: Container(
            color: Colors.grey[400],
            width: widget.width,
            height: widget.height,
            // child: Container(
            //   // margin: const EdgeInsets.all(10.0),
            //   color: Colors.amber[600],
            //   width: 50,
            //   height: 50,
          child: FractionallySizedBox(
              widthFactor: widget.fraction,
              heightFactor: 1,
              alignment: FractionalOffset.centerLeft,
              child: Container(
                // color: Colors.amber[600]
                // color: const Color.fromARGB (255, red, green,0)
                color: getColor(),
          )
    )
        )
    );
  }
}
