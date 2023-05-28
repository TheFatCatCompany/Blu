import 'package:crypto_app/BluetoothModule/Scanner.dart';
import 'package:flutter/material.dart';

class IgnoreButton extends StatefulWidget {
  final BluetoothScanner scanner;
  final String deviceID;
  const IgnoreButton({Key? key, required this.scanner, required this.deviceID}) : super(key: key);

  @override
  _IgnoreButtonState createState() => _IgnoreButtonState();
}
class _IgnoreButtonState extends State<IgnoreButton> {
  bool ignore = false;
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
              widget.scanner.unignoreDevice(widget.deviceID);
            }
            else{
              ignore = true;
              widget.scanner.ignoreDevice(widget.deviceID);
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