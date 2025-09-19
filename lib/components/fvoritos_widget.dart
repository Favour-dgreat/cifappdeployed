import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'fvoritos_model.dart';
export 'fvoritos_model.dart';

class FvoritosWidget extends StatefulWidget {
  const FvoritosWidget({super.key});

  @override
  State<FvoritosWidget> createState() => _FvoritosWidgetState();
}

class _FvoritosWidgetState extends State<FvoritosWidget> {
  late FvoritosModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FvoritosModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 4.0,
        ),
      ),
    );
  }
}
