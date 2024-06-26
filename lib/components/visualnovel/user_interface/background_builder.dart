import 'package:flutter/material.dart';

class BackgroundBuilder extends StatefulWidget {
  BackgroundBuilder({
    Key? key,
    this.image,
  }) : super(key: key);

  final String? image;
  @override
  _BackgroundBuilderState createState() => _BackgroundBuilderState();
}

class _BackgroundBuilderState extends State<BackgroundBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget.image != null) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.image!),
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          return Container(
            color: Colors.red,
            child: Center(
              child: Text(
                "Error!\nPlease ensure that you have defined the correct background image.",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      },
    );
  }
}
