import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'more_model.dart';
import '../../pages/Godsword_for_today/newsletter_widget.dart';
export 'more_model.dart';

class MoreWidget extends StatefulWidget {
  const MoreWidget({super.key});

  @override
  State<MoreWidget> createState() => _MoreWidgetState();
}

class _MoreWidgetState extends State<MoreWidget> {
  late MoreModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 4; // 'More' tab is selected by default

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MoreModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Align(
                  alignment: const AlignmentDirectional(0.0, -1.0),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 770.0),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          primary: false,
                          child: SizedBox(
                            height: 116.0,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(
                                    -1.0,
                                    1.0,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          24.0,
                                          0.0,
                                          0.0,
                                          0.0,
                                        ),
                                    child: Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                        color:
                                            FlutterFlowTheme.of(
                                              context,
                                            ).accent2,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).secondary,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: AuthUserStreamWidget(
                                          builder:
                                              (context) => ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration:
                                                      const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: CachedNetworkImage(
                                                    fadeInDuration:
                                                        const Duration(
                                                          milliseconds: 500,
                                                        ),
                                                    fadeOutDuration:
                                                        const Duration(
                                                          milliseconds: 500,
                                                        ),
                                                    imageUrl:
                                                        (_model.uploadedFileUrl !=
                                                                    null &&
                                                                _model
                                                                    .uploadedFileUrl
                                                                    .isNotEmpty)
                                                            ? _model
                                                                .uploadedFileUrl
                                                            : valueOrDefault<
                                                              String
                                                            >(
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0,
                            12.0,
                            0.0,
                            0.0,
                          ),
                          child: AuthUserStreamWidget(
                            builder:
                                (context) => Text(
                                  currentUserDisplayName.isNotEmpty
                                      ? currentUserDisplayName
                                      : 'Welcome Guest',
                                  style: FlutterFlowTheme.of(
                                    context,
                                  ).displaySmall.override(
                                    fontFamily:
                                        FlutterFlowTheme.of(
                                          context,
                                        ).displaySmallFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                          FlutterFlowTheme.of(
                                            context,
                                          ).displaySmallFamily,
                                        ),
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0,
                            12.0,
                            20.0,
                            0.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 70.0,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(
                                    context,
                                  ).secondaryBackground,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3.0,
                                  color: Color(0x33000000),
                                  offset: Offset(0.0, 1.0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await launchURL(
                                    'https://www.42ndgenerationfoundation.com/achieversfaithdigest/42nd-generation-foundation-library/',
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.menu_book,
                                      color:
                                          FlutterFlowTheme.of(
                                            context,
                                          ).secondaryText,
                                      size: 24.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            12.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                          ),
                                      child: Text(
                                        '42nd Generation Foundation Library ',
                                        style: FlutterFlowTheme.of(
                                          context,
                                        ).labelLarge.override(
                                          fontFamily:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).labelLargeFamily,
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

                                    Expanded(
                                      child: Align(
                                        alignment: const AlignmentDirectional(
                                          0.9,
                                          0.0,
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await launchURL(
                                              'https://www.42ndgenerationfoundation.com/achieversfaithdigest/42nd-generation-foundation-library/',
                                            );
                                          },
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                FlutterFlowTheme.of(
                                                  context,
                                                ).secondaryText,
                                            size: 18.0,
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0,
                            12.0,
                            20.0,
                            0.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 70.0,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(
                                    context,
                                  ).secondaryBackground,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3.0,
                                  color: Color(0x33000000),
                                  offset: Offset(0.0, 1.0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'Websites',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: const TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                      ),
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.link_sharp,
                                      color:
                                          FlutterFlowTheme.of(
                                            context,
                                          ).secondaryText,
                                      size: 24.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            12.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                          ),
                                      child: Text(
                                        'Websites',
                                        style: FlutterFlowTheme.of(
                                          context,
                                        ).labelLarge.override(
                                          fontFamily:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).labelLargeFamily,
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
                                    Expanded(
                                      child: Align(
                                        alignment: const AlignmentDirectional(
                                          0.9,
                                          0.0,
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              'Websites',
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    const TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                    ),
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                FlutterFlowTheme.of(
                                                  context,
                                                ).secondaryText,
                                            size: 18.0,
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0,
                            12.0,
                            20.0,
                            0.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 70.0,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(
                                    context,
                                  ).secondaryBackground,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3.0,
                                  color: Color(0x33000000),
                                  offset: Offset(0.0, 1.0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'PrivacyPolicy',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: const TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                      ),
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.privacy_tip,
                                      color:
                                          FlutterFlowTheme.of(
                                            context,
                                          ).secondaryText,
                                      size: 24.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            12.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                          ),
                                      child: Text(
                                        'Privacy Policy',
                                        style: FlutterFlowTheme.of(
                                          context,
                                        ).labelLarge.override(
                                          fontFamily:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).labelLargeFamily,
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
                                    Expanded(
                                      child: Align(
                                        alignment: const AlignmentDirectional(
                                          0.9,
                                          0.0,
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              'PrivacyPolicy',
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    const TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                    ),
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                FlutterFlowTheme.of(
                                                  context,
                                                ).secondaryText,
                                            size: 18.0,
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0,
                            12.0,
                            20.0,
                            0.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 70.0,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(
                                    context,
                                  ).secondaryBackground,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3.0,
                                  color: Color(0x33000000),
                                  offset: Offset(0.0, 1.0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'Questions',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: const TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                            PageTransitionType.bottomToTop,
                                      ),
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.question_answer,
                                      color:
                                          FlutterFlowTheme.of(
                                            context,
                                          ).secondaryText,
                                      size: 24.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            12.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                          ),
                                      child: Text(
                                        'Contact Us',
                                        style: FlutterFlowTheme.of(
                                          context,
                                        ).labelLarge.override(
                                          fontFamily:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).labelLargeFamily,
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
                                    Expanded(
                                      child: Align(
                                        alignment: const AlignmentDirectional(
                                          0.9,
                                          0.0,
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              'Questions',
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    const TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                    ),
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                FlutterFlowTheme.of(
                                                  context,
                                                ).secondaryText,
                                            size: 18.0,
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0,
                            12.0,
                            20.0,
                            0.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 70.0,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(
                                    context,
                                  ).secondaryBackground,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3.0,
                                  color: Color(0x33000000),
                                  offset: Offset(0.0, 1.0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  // Navigate to NewsletterWidget
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const NewsletterWidget(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.bookBible,
                                      color:
                                          FlutterFlowTheme.of(
                                            context,
                                          ).secondaryText,
                                      size: 24.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            12.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                          ),
                                      child: Text(
                                        'God\'s Word For Today',
                                        style: FlutterFlowTheme.of(
                                          context,
                                        ).labelLarge.override(
                                          fontFamily:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).labelLargeFamily,
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
                                    Expanded(
                                      child: Align(
                                        alignment: const AlignmentDirectional(
                                          0.9,
                                          0.0,
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => const NewsletterWidget(),
                                              ),
                                            );
                                          },

                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                FlutterFlowTheme.of(
                                                  context,
                                                ).secondaryText,
                                            size: 18.0,
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0,
                            10.0,
                            10.0,
                            10.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(
                                    context,
                                  ).secondaryBackground,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3.0,
                                  color: Color(0x33000000),
                                  offset: Offset(0.0, 1.0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color:
                                    FlutterFlowTheme.of(
                                      context,
                                    ).secondaryBackground,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.facebook,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 30.0,
                                    ),
                                    onPressed: () async {
                                      await launchURL(
                                        'https://web.facebook.com/profile.php?id=61557626190035',
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.xTwitter,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 30.0,
                                    ),
                                    onPressed: () async {
                                      await launchURL(
                                        'https://x.com/CEFMorsiGlobal',
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.youtube,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 30.0,
                                    ),
                                    onPressed: () async {
                                      await launchURL(
                                        'https://www.youtube.com/@cefmorsimi',
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 30.0,
                                    ),
                                    onPressed: () async {
                                      await launchURL(
                                        'https://chat.whatsapp.com/ChYcWAd7tzR44S21Ie9zyL',
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.instagram,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 30.0,
                                    ),
                                    onPressed: () async {
                                      await launchURL(
                                        'https://www.instagram.com/cefmorsi_global/',
                                      );
                                    },
                                  ),
                                ].divide(const SizedBox(width: 20.0)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Center(
                          child: Text(
                            "Developed by CEFMORSI Global Workspace Team",
                            style: FlutterFlowTheme.of(
                              context,
                            ).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily,
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
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: const Color(0xFF309C96),
          unselectedItemColor: const Color(0xFF616161),
          showUnselectedLabels: true,
          onTap: (index) {
            if (index == _currentIndex)
              return; // Prevent navigating to the same page
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
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
            BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: 'More'),
          ],
        ),
      ),
    );
  }
}
