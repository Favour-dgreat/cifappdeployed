import 'package:Cefmorsi/components/profile_info_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../account_profile_creation/auth_2_edit_profile/auth2_edit_profile_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'questions_model.dart';
export 'questions_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuestionsWidget extends StatefulWidget {
  const QuestionsWidget({super.key});

  @override
  State<QuestionsWidget> createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends State<QuestionsWidget> {
  late QuestionsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 4; // 'More' tab is selected by default

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuestionsModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> sendEmail(String senderEmail, String message) async {
    final url = Uri.parse('https://api.brevo.com/v3/smtp/email');
    final response = await http.post(
      url,
      headers: {'api-key': dotenv.env['API_KEY'] ?? ''},
      body: jsonEncode({
        'sender': {'email': senderEmail},
        'to': [
          {
            'email': 'request@42ndgenerationfoundation.com',
          }, // Replace with your email
        ],
        'subject': 'New Question, Feedback/Prayer Request',
        'htmlContent': '<p>$message</p>',
      }),
    );

    if (response.statusCode == 201) {
      print('Email sent successfully');
    } else {
      print('Failed to send email: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0,
                        0.0,
                        16.0,
                        0.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder(
                            builder:
                                (context) => FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  borderWidth: 1,
                                  buttonSize: 44,
                                  icon: Icon(
                                    Icons.menu_rounded,
                                    color:
                                        FlutterFlowTheme.of(
                                          context,
                                        ).primaryText,
                                    size: 24,
                                  ),
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(
                                            0,
                                            0,
                                          ).resolve(Directionality.of(context)),
                                          child: Container(
                                            // Replace WebViewAware with a generic container or appropriate widget
                                            child: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(
                                                  dialogContext,
                                                ).unfocus();
                                                FocusManager
                                                    .instance
                                                    .primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: ProfileInfoWidget(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                          ),
                          Container(
                            width: 44.0,
                            height: 44.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: AuthUserStreamWidget(
                                builder:
                                    (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    const Auth2EditProfileWidget(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: CachedNetworkImage(
                                          fadeInDuration: const Duration(
                                            milliseconds: 500,
                                          ),
                                          fadeOutDuration: const Duration(
                                            milliseconds: 500,
                                          ),
                                          imageUrl:
                                              (_model.uploadedFileUrl != null &&
                                                      _model
                                                          .uploadedFileUrl
                                                          .isNotEmpty)
                                                  ? _model.uploadedFileUrl
                                                  : valueOrDefault<String>(
                                                    currentUserPhoto,
                                                    'https://res.cloudinary.com/dsohqp4d9/image/upload/w_1000,c_fill,ar_1:1,g_auto,r_max,bo_5px_solid_red,b_rgb:262c35/v1749123208/annie-spratt-yI3weKNBRTc-unsplash_1_slup0a.jpg',
                                                  ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ].addToStart(const SizedBox(height: 20.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  0.0,
                  20.0,
                  0.0,
                  30.0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        10.0,
                        0.0,
                        0.0,
                      ),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'Contact Us',
                        options: FFButtonOptions(
                          width: 201.0,
                          height: 42.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0,
                            0.0,
                            16.0,
                            0.0,
                          ),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                          ),
                          color: const Color(0xFFD4E9E8),
                          textStyle: FlutterFlowTheme.of(
                            context,
                          ).titleSmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: FlutterFlowTheme.of(context).primary,
                            fontSize: 22.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).titleSmallFamily,
                            ),
                          ),
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ].addToStart(const SizedBox(width: 30.0)),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0,
                          12.0,
                          10.0,
                          0.0,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  0.0,
                                  0.0,
                                  10.0,
                                ),
                                child: Text(
                                  'Fill the form below to reach out to us with your Questions, Feedback and Prayer Requests.',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(
                                    context,
                                  ).labelLarge.override(
                                    fontFamily:
                                        FlutterFlowTheme.of(
                                          context,
                                        ).bodyMediumFamily,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                          FlutterFlowTheme.of(
                                            context,
                                          ).labelLargeFamily,
                                        ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0,
                                  16.0,
                                  0.0,
                                  0.0,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0.0,
                                            0.0,
                                            0.0,
                                            30.0,
                                          ),
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 4.0,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color:
                                                FlutterFlowTheme.of(
                                                  context,
                                                ).primaryBackground,
                                            borderRadius:
                                                const BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                          ),
                                            child: TextFormField(
                                            controller: _model.textController1,
                                            focusNode: _model.textFieldFocusNode1,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Email Address',
                                              labelStyle: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .copyWith(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.normal,
                                                ),
                                              enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                BorderRadius.circular(12.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0x00000000),
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                BorderRadius.circular(12.0),
                                              ),
                                              contentPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                              16.0,
                                              12.0,
                                              16.0,
                                              12.0,
                                              ),
                                              prefixIcon: Icon(
                                              Icons.email_rounded,
                                              color: FlutterFlowTheme.of(context).primary,
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .copyWith(
                                                letterSpacing: 0.0,
                                              ),
                                            cursorColor:
                                              FlutterFlowTheme.of(context).primary,
                                            validator: _model.textController1Validator
                                              .asValidator(context),
                                            ),
                                          ),
                                          ),
                                        ),
                                        Material(
                                          color: Colors.transparent,
                                          elevation: 4.0,
                                          shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          ),
                                          child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                            borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0),
                                            ),
                                          ),
                                          child: TextFormField(
                                            controller: _model.textController2,
                                            focusNode: _model.textFieldFocusNode2,
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                            labelText:
                                              'Questions, Feedback & Prayer Requests',
                                            labelStyle: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .copyWith(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                              width: 2.0,
                                              ),
                                              borderRadius:
                                                BorderRadius.circular(12.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 2.0,
                                              ),
                                              borderRadius:
                                                BorderRadius.circular(12.0),
                                            ),
                                            contentPadding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                              16.0,
                                              30.0,
                                              16.0,
                                              12.0,
                                            ),
                                            prefixIcon: Icon(
                                              Icons.edit,
                                              color: FlutterFlowTheme.of(context).primary,
                                            ),
                                            ),
                                          style: FlutterFlowTheme.of(
                                            context,
                                          ).bodyMedium.override(
                                            fontFamily:
                                                FlutterFlowTheme.of(
                                                  context,
                                                ).bodyMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).bodyMediumFamily,
                                                ),
                                          ),
                                          maxLines: 10,
                                          cursorColor:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).primary,
                                          validator: _model
                                              .textController2Validator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                  ].divide(const SizedBox(height: 5.0)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  24,
                                  0,
                                  12,
                                ),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    final senderEmail =
                                        _model.textController1.text;
                                    final message = _model.textController2.text;
                                    final scaffoldMessenger =
                                        ScaffoldMessenger.of(context);

                                    try {
                                      await sendEmail(senderEmail, message);
                                      scaffoldMessenger.showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Request received successfully',
                                          ),
                                        ),
                                      );
                                    } catch (e) {
                                      scaffoldMessenger.showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Failed to send request. Try again later.',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  text: 'Submit',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 48.0,
                                    padding: const EdgeInsets.all(0.0),
                                    iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                        ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(
                                      context,
                                    ).titleSmall.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(
                                            context,
                                          ).titleSmallFamily,
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                            FlutterFlowTheme.of(
                                              context,
                                            ).titleSmallFamily,
                                          ),
                                    ),
                                    elevation: 4.0,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                            ].addToEnd(const SizedBox(height: 30.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: const Color(0xFF309C96),
          unselectedItemColor: const Color(0xFF616161),
          showUnselectedLabels: true,
          onTap: (index) {
        if (index == _currentIndex) return; // Prevent navigating to the same page
          setState(() {
        _currentIndex = index;
          });
          switch (index) {
          case 0:
        context.goNamed('Home');
        break;
          case 1:
        context.goNamed('Magazines');
        break;
          case 2:
        context.goNamed('Books');
        break;
          case 3:
        context.goNamed('Events');
        break;
          case 4:
        context.goNamed('more');
        break;
          }
            },
            items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Magazines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Books',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.podcasts_sharp),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'More',
          ),
            ],
        ),
      ),
    );
  }
}
