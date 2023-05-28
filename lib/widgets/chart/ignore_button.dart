import 'package:flutter/material.dart';

class IgnoreButton extends StatefulWidget {
  const IgnoreButton({Key? key}) : super(key: key);

  @override
  State<IgnoreButton> createState() => _IgnoreButtonState();
}

class _IgnoreButtonState extends State<IgnoreButton> {
  bool ignore = true;
  Color foreground = Colors.white;
  Color background = Colors.lightBlue;
  String ignoreText = "Ignore";

  Color get_foreground(){
    if (ignore == false) {
      return Colors.white;
    } else {
      return Colors.deepPurple;
    }
  }
  Color get_background(){
    if (ignore == false) {
      return Colors.lightBlue;
    } else {
      return Colors.grey;
    }
  }
  String get_text(){
    if (ignore == true) {
      return "Unignore";
    } else {
      return "Ignore";
    }
  }

  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return Center(
        child: TextButton(
        child: Text(get_text(), style: TextStyle(fontSize: 20.0),),
    onPressed: () {
          setState((){
            if (ignore == true){
              ignore = false;
            }
            else{
              ignore = true;
            }
          });
    },
    style: TextButton.styleFrom(
    foregroundColor: get_foreground(),
    backgroundColor: get_background(),
    elevation: 10)
    )
    );
  }
}