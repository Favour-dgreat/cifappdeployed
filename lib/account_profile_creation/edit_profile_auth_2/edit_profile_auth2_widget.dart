import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_profile_auth2_model.dart';
export 'edit_profile_auth2_model.dart';

class EditProfileAuth2Widget extends StatefulWidget {
  const EditProfileAuth2Widget({
    super.key,
    this.firstName,
    this.lastName,
    this.PhotoUrl,
    this.email,
    String? title,
    String? confirmButtonText,
    required this.navigateAction,
    required this.confirmButtonTextStyle,
    TextEditingController? firstNameTextController,
    TextEditingController? lastNameTextController,
    TextEditingController? myBioTextController,
  }) : title = title ?? 'Edit Profile',
       confirmButtonText = confirmButtonText ?? 'Save Changes';
  final String? firstName;
  final String? lastName;
  final String? PhotoUrl;
  final String? email;
  final String title;
  final String confirmButtonText;
  final Future Function()? navigateAction;
  final TextStyle confirmButtonTextStyle;

  @override
  State<EditProfileAuth2Widget> createState() => _EditProfileAuth2WidgetState();
}

class _EditProfileAuth2WidgetState extends State<EditProfileAuth2Widget> {
  late EditProfileAuth2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProfileAuth2Model());

    _model.firstNameTextController ??= TextEditingController(
      text: currentUserDisplayName,
    );
    _model.firstNameTextController ??= TextEditingController(
      text: widget.firstName ?? currentUserDisplayName.split(' ').first,
    );
    _model.lastNameTextController ??= TextEditingController(
      text:
          widget.lastName ??
          currentUserDisplayName.split(' ').skip(1).join(' '),
    );
    _model.myBioTextController ??= TextEditingController(
      text: valueOrDefault(currentUserDocument?.shortDescription, ''),
    );
    _model.myBioFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _model.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: const AlignmentDirectional(0.0, -1.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                0.0,
                12.0,
                0.0,
                0.0,
              ),
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).accent2,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).secondary,
                    width: 2.0,
                  ),
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: AuthUserStreamWidget(
                          builder:
                              (context) => ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: CachedNetworkImage(
                                  fadeInDuration: const Duration(
                                    milliseconds: 200,
                                  ),
                                  fadeOutDuration: const Duration(
                                    milliseconds: 200,
                                  ),
                                  imageUrl:
                                      _model.uploadedFileUrl.isNotEmpty
                                          ? _model.uploadedFileUrl
                                          : valueOrDefault<String>(
                                            currentUserPhoto,
                                            'https://res.cloudinary.com/dsohqp4d9/image/upload/w_1000,c_fill,ar_1:1,g_auto,r_max,bo_5px_solid_red,b_rgb:262c35/v1749123208/annie-spratt-yI3weKNBRTc-unsplash_1_slup0a.jpg',
                                          ),
                                  width: 300.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0.0, -1.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                0.0,
                12.0,
                0.0,
                32.0,
              ),
              child: FFButtonWidget(
                onPressed: () async {
                  final selectedMedia = await selectMedia(
                    mediaSource: MediaSource.photoGallery,
                    multiImage: false,
                  );
                  if (selectedMedia != null &&
                      selectedMedia.every(
                        (m) => validateFileFormat(m.storagePath, context),
                      )) {
                    safeSetState(() => _model.isDataUploading = true);
                    var selectedUploadedFiles = <FFUploadedFile>[];
                    var downloadUrls = <String>[];

                    try {
                      showUploadMessage(
                        context,
                        'Uploading file...',
                        showLoading: true,
                      );

                      selectedUploadedFiles =
                          selectedMedia
                              .map(
                                (m) => FFUploadedFile(
                                  name: m.storagePath.split('/').last,
                                  bytes: m.bytes,
                                  height: m.dimensions?.height,
                                  width: m.dimensions?.width,
                                  blurHash: m.blurHash,
                                ),
                              )
                              .toList();

                      downloadUrls =
                          (await Future.wait(
                            selectedMedia.map(
                              (m) async =>
                                  await uploadData(m.storagePath, m.bytes),
                            ),
                          )).where((u) => u != null).map((u) => u!).toList();
                    } finally {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      _model.isDataUploading = false;
                    }

                    if (selectedUploadedFiles.length == selectedMedia.length &&
                        downloadUrls.length == selectedMedia.length) {
                      final newPhotoUrl = downloadUrls.first;
                      safeSetState(() {
                        _model.uploadedLocalFile = selectedUploadedFiles.first;
                        _model.uploadedFileUrl = newPhotoUrl;
                      });

                      // Update user's photo in Firebase Auth and Firestore
                      await currentUserReference!.update({
                        'photo_url': newPhotoUrl,
                      });

                      showUploadMessage(context, 'Success!');
                    } else {
                      safeSetState(() {});
                      showUploadMessage(context, 'Failed to upload data');
                    }
                  }
                },
                text: 'Change Photo',
                options: FFButtonOptions(
                  width: 130.0,
                  height: 40.0,
                  padding: EdgeInsets.zero,
                  iconPadding: EdgeInsets.zero,
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    letterSpacing: 0.0,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).bodyMediumFamily,
                    ),
                  ),
                  elevation: 1.0,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              20.0,
              0.0,
              20.0,
              12.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: AuthUserStreamWidget(
                    builder:
                        (context) => TextFormField(
                          controller:
                              _model.firstNameTextController ??=
                                  TextEditingController(
                                    text:
                                        currentUserDisplayName.split(' ').first,
                                  ),
                          focusNode: _model.firstNameFocusNode ??= FocusNode(),
                          autofillHints: const [AutofillHints.givenName],
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            labelStyle: FlutterFlowTheme.of(
                              context,
                            ).labelMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(
                                    context,
                                  ).labelMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).labelMediumFamily,
                              ),
                            ),
                            hintText: 'First name...',
                            hintStyle: FlutterFlowTheme.of(
                              context,
                            ).labelMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(
                                    context,
                                  ).labelMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).labelMediumFamily,
                              ),
                            ),
                            errorStyle: FlutterFlowTheme.of(
                              context,
                            ).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).error,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                  16.0,
                                  12.0,
                                  0.0,
                                  12.0,
                                ),
                          ),
                          style: FlutterFlowTheme.of(
                            context,
                          ).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                            ),
                          ),
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          validator: _model.firstNameTextControllerValidator
                              .asValidator(context),
                        ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: AuthUserStreamWidget(
                    builder:
                        (context) => TextFormField(
                          controller:
                              _model.lastNameTextController ??=
                                  TextEditingController(
                                    text: currentUserDisplayName
                                        .split(' ')
                                        .skip(1)
                                        .join(' '),
                                  ),
                          focusNode: _model.lastNameFocusNode ??= FocusNode(),
                          autofillHints: const [AutofillHints.familyName],
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            labelStyle: FlutterFlowTheme.of(
                              context,
                            ).labelMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(
                                    context,
                                  ).labelMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).labelMediumFamily,
                              ),
                            ),
                            hintText: 'Last name...',
                            hintStyle: FlutterFlowTheme.of(
                              context,
                            ).labelMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(
                                    context,
                                  ).labelMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).labelMediumFamily,
                              ),
                            ),
                            errorStyle: FlutterFlowTheme.of(
                              context,
                            ).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).error,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                  16.0,
                                  12.0,
                                  0.0,
                                  12.0,
                                ),
                          ),
                          style: FlutterFlowTheme.of(
                            context,
                          ).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                            ),
                          ),
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          validator: _model.lastNameTextControllerValidator
                              .asValidator(context),
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              20.0,
              0.0,
              20.0,
              12.0,
            ),
            child: AuthUserStreamWidget(
              builder:
                  (context) => TextFormField(
                    controller: _model.myBioTextController,
                    focusNode: _model.myBioFocusNode,
                    textCapitalization: TextCapitalization.sentences,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Tell Us About You',
                      labelStyle: FlutterFlowTheme.of(
                        context,
                      ).labelMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).labelMediumFamily,
                        ),
                      ),
                      hintText: 'A little about you...',
                      hintStyle: FlutterFlowTheme.of(
                        context,
                      ).labelMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).labelMediumFamily,
                        ),
                      ),
                      errorStyle: FlutterFlowTheme.of(
                        context,
                      ).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        color: FlutterFlowTheme.of(context).error,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).bodyMediumFamily,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                      contentPadding: const EdgeInsetsDirectional.fromSTEB(
                        16.0,
                        12.0,
                        0.0,
                        12.0,
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      letterSpacing: 0.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).bodyMediumFamily,
                      ),
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    cursorColor: FlutterFlowTheme.of(context).primary,
                    validator: _model.myBioTextControllerValidator.asValidator(
                      context,
                    ),
                  ),
            ),
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FFButtonWidget(
                  onPressed:
                      _model.isDataUploading
                          ? null
                          : () async {
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              return;
                            }
                
                            setState(() {
                              _model.isDataUploading = true;
                            });
                
                            try {
                              final firstName =
                                  _model.firstNameTextController?.text.trim() ??
                                  '';
                              final lastName =
                                  _model.lastNameTextController?.text.trim() ??
                                  '';
                              final myBio =
                                  _model.myBioTextController?.text.trim() ?? '';
                              final displayName = firstName;
                              final fullName = '$firstName $lastName'; 
                                         
                              // Update Firestore user record
                              await currentUserReference?.update({
                                'first_name': firstName,
                                'last_name': lastName,
                                'email': currentUserEmail,
                                'short_description': myBio,
                                'display_name': displayName,
                                'photo_url': _model.uploadedFileUrl,
                                'full_name': fullName,
                              });
                
                              // Update Firebase Auth display name
                              await currentUser?.updateDisplayName(displayName);
                              // Navigate if provided
                              await widget.navigateAction?.call();
                            } catch (e) {
                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to update profile: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } finally {
                              setState(() {
                                _model.isDataUploading = false;
                              });
                            }
                          },
                  text: widget.confirmButtonText,
                  options: FFButtonOptions(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    iconPadding: EdgeInsets.zero,
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: widget.confirmButtonTextStyle,
                    elevation: 3.0,
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),

              // Optional loading overlay
              if (_model.isDataUploading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
