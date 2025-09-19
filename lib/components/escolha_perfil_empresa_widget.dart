import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'escolha_perfil_empresa_model.dart';
export 'escolha_perfil_empresa_model.dart';

class EscolhaPerfilEmpresaWidget extends StatefulWidget {
  const EscolhaPerfilEmpresaWidget({super.key});

  @override
  State<EscolhaPerfilEmpresaWidget> createState() =>
      _EscolhaPerfilEmpresaWidgetState();
}

class _EscolhaPerfilEmpresaWidgetState
    extends State<EscolhaPerfilEmpresaWidget> {
  late EscolhaPerfilEmpresaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EscolhaPerfilEmpresaModel());
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
