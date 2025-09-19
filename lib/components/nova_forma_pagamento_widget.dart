import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'nova_forma_pagamento_model.dart';
export 'nova_forma_pagamento_model.dart';

class NovaFormaPagamentoWidget extends StatefulWidget {
  const NovaFormaPagamentoWidget({super.key});

  @override
  State<NovaFormaPagamentoWidget> createState() =>
      _NovaFormaPagamentoWidgetState();
}

class _NovaFormaPagamentoWidgetState extends State<NovaFormaPagamentoWidget> {
  late NovaFormaPagamentoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NovaFormaPagamentoModel());
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
