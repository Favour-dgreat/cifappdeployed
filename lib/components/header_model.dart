import '/flutter_flow/flutter_flow_util.dart';
import 'header_widget.dart' show HeaderWidget;
import 'package:flutter/material.dart';

class HeaderModel extends FlutterFlowModel<HeaderWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Slider1 widget.
  PageController? slider1Controller;

  int get slider1CurrentIndex => slider1Controller != null &&
          slider1Controller!.hasClients &&
          slider1Controller!.page != null
      ? slider1Controller!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
