import '/flutter_flow/flutter_flow_util.dart';
import 'sign_up_widget.dart' show SignUpWidget;
import 'package:flutter/material.dart';

class SignUpModel extends FlutterFlowModel<SignUpWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for fullname widget.
  FocusNode? fullnameFocusNode;
  TextEditingController? fullnameTextController;
  String? Function(BuildContext, String?)? fullnameTextControllerValidator;
  // State field(s) for emailaddress widget.
  FocusNode? emailaddressFocusNode;
  TextEditingController? emailaddressTextController;
  String? Function(BuildContext, String?)? emailaddressTextControllerValidator;
  // State field(s) for phonenumber widget.
  FocusNode? phonenumberFocusNode;
  TextEditingController? phonenumberTextController;
  String? Function(BuildContext, String?)? phonenumberTextControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
  }

  @override
  void dispose() {
    fullnameFocusNode?.dispose();
    fullnameTextController?.dispose();

    emailaddressFocusNode?.dispose();
    emailaddressTextController?.dispose();

    phonenumberFocusNode?.dispose();
    phonenumberTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();
  }

  /// Action blocks.
  Future oTPCreation(BuildContext context) async {}
}
