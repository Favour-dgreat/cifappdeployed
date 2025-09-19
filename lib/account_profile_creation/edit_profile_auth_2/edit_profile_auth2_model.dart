import '/flutter_flow/flutter_flow_util.dart';
import 'edit_profile_auth2_widget.dart' show EditProfileAuth2Widget;
import 'package:flutter/material.dart';

class EditProfileAuth2Model extends FlutterFlowModel<EditProfileAuth2Widget> {
  /// State fields for stateful widgets in this component.
  final formKey = GlobalKey<FormState>();

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile = FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for yourName widget.
  FocusNode? firstNameFocusNode;
  TextEditingController? firstNameTextController;

  FocusNode? lastNameFocusNode;
  TextEditingController? lastNameTextController;

  String? Function(BuildContext, String?)? firstNameTextControllerValidator;
  String? Function(BuildContext, String?)? lastNameTextControllerValidator;

  // State field(s) for myBio widget.
  FocusNode? myBioFocusNode;
  TextEditingController? myBioTextController;
  String? Function(BuildContext, String?)? myBioTextControllerValidator;

  @override
  void initState(BuildContext context) {
    firstNameFocusNode = FocusNode();
    lastNameFocusNode = FocusNode();
    myBioFocusNode = FocusNode();
    
    firstNameTextController = TextEditingController();
    lastNameTextController = TextEditingController();
    myBioTextController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameFocusNode?.dispose();
    lastNameFocusNode?.dispose();
    myBioFocusNode?.dispose();

    firstNameTextController?.dispose();
    lastNameTextController?.dispose();
    myBioTextController?.dispose();
  }
}
