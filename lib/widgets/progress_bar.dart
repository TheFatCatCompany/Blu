import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: ProgressBar(),
));


class ProgressBar extends StatefulWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return Container(
      // decoration: BoxDecoration(
      //   color: const Color(0xff7c94b6),
      //   border: Border.all(
      //     width: 8,
      //   ),
      //   borderRadius: BorderRadius.circular(12),
      // )
      margin: const EdgeInsets.all(10.0),
      color: Colors.amber[600],
      width: 48.0,
      height: 48.0,
    );
  }
}
