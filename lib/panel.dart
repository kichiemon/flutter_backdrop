import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PanelState extends ChangeNotifier {
  AnimationController controller;

  PanelState({this.controller});

  get isVisible => this.isVisible;

  void toggleVisible() {
    this.notifyListeners();
  }
}

class Panel extends StatefulWidget {
  AnimationController controller;
  Panel({this.controller});
  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> with SingleTickerProviderStateMixin {
  AnimationController controller;

  static const header_height = 32.0;

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    final frontPanelHeight = -header_height;

    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frontPanelHeight),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(CurvedAnimation(parent: widget.controller, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: bodyWidget);
  }

  Widget bodyWidget(BuildContext context, BoxConstraints constraints) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: <Widget>[
            const Center(child: const Text("Panel")),
            PositionedTransition(
              rect: getPanelAnimation(constraints),
              child: Material(
                elevation: 12.0,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: header_height,
                      width: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: const Radius.circular(16.0),
                          topRight: const Radius.circular(16.0),
                        ),
                      ),
                      child: const Text("List"),
                    ),
                    const Expanded(
                      child: const Center(
                        child: const Text("Expended"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
