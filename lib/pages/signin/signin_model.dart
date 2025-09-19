import '/flutter_flow/flutter_flow_util.dart';
import 'signin_widget.dart' show SigninWidget;
import 'package:flutter/material.dart';

class SigninModel extends FlutterFlowModel<SigninWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for emailaddresssignin widget.
  FocusNode? emailaddresssigninFocusNode;
  TextEditingController? emailaddresssigninTextController;
  String? Function(BuildContext, String?)?
      emailaddresssigninTextControllerValidator;
  // State field(s) for passwordsignin widget.
  FocusNode? passwordsigninFocusNode;
  TextEditingController? passwordsigninTextController;
  late bool passwordsigninVisibility;
  String? Function(BuildContext, String?)?
      passwordsigninTextControllerValidator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  @override
  void initState(BuildContext context) {
    passwordsigninVisibility = false;
  }

  @override
  void dispose() {
    emailaddresssigninFocusNode?.dispose();
    emailaddresssigninTextController?.dispose();

    passwordsigninFocusNode?.dispose();
    passwordsigninTextController?.dispose();
  }
}
