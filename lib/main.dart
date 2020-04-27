import 'package:flutter/material.dart';
import 'package:flutter_backdrop/panel.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.amber),
    home: Backdrop(),
  ));
}

class Backdrop extends StatefulWidget {
  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      value: 1.0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = _animationController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Backdrop UI"),
        elevation: 2.0,
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.arrow_menu,
            progress: _animationController.view,
          ),
          onPressed: () =>
              _animationController.fling(velocity: isPanelVisible ? -1.0 : 1.0),
        ),
      ),
      body: Panel(controller: _animationController),
    );
  }
}
