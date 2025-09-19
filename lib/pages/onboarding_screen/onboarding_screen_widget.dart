import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_screen_model.dart';
export 'onboarding_screen_model.dart';

class OnboardingScreenWidget extends StatefulWidget {
  const OnboardingScreenWidget({super.key});

  @override
  State<OnboardingScreenWidget> createState() => _OnboardingScreenWidgetState();
}

class _OnboardingScreenWidgetState extends State<OnboardingScreenWidget>
    with TickerProviderStateMixin {
  late OnboardingScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingScreenModel());

    animationsMap.addAll({
      'imageOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              ScaleEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(1.2, 1.2),
                end: const Offset(1.0, 1.0),
              ),
            ],
      ),
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              MoveEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(0.0, 60.0),
                end: const Offset(0.0, 0.0),
              ),
            ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              MoveEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(0.0, 80.0),
                end: const Offset(0.0, 0.0),
              ),
            ],
      ),
      'iconButtonOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              ScaleEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(0.4, 0.4),
                end: const Offset(1.0, 1.0),
              ),
            ],
      ),
      'imageOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              ScaleEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(1.2, 1.2),
                end: const Offset(1.0, 1.0),
              ),
            ],
      ),
      'textOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              MoveEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(0.0, 60.0),
                end: const Offset(0.0, 0.0),
              ),
            ],
      ),
      'textOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              MoveEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(0.0, 80.0),
                end: const Offset(0.0, 0.0),
              ),
            ],
      ),
      'iconButtonOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              ScaleEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(0.5, 0.5),
                end: const Offset(1.0, 1.0),
              ),
            ],
      ),
      'imageOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              ScaleEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(1.2, 1.2),
                end: const Offset(1.0, 1.0),
              ),
            ],
      ),
      'textOnPageLoadAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              MoveEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(0.0, 60.0),
                end: const Offset(0.0, 0.0),
              ),
            ],
      ),
      'textOnPageLoadAnimation6': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              MoveEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(0.0, 80.0),
                end: const Offset(0.0, 0.0),
              ),
            ],
      ),
      'iconButtonOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              ScaleEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(0.5, 0.5),
                end: const Offset(1.0, 1.0),
              ),
            ],
      ),
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              ScaleEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(1.4, 1.4),
                end: const Offset(1.0, 1.0),
              ),
            ],
      ),
      'textOnPageLoadAnimation7': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              MoveEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(0.0, 70.0),
                end: const Offset(0.0, 0.0),
              ),
            ],
      ),
      'textOnPageLoadAnimation8': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              MoveEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(0.0, 90.0),
                end: const Offset(0.0, 0.0),
              ),
            ],
      ),
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder:
            () => [
              FadeEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: 0.0,
                end: 1.0,
              ),
              MoveEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(0.0, 100.0),
                end: const Offset(0.0, 0.0),
              ),
              ScaleEffect(
                curve: Curves.easeInOut,
                delay: 0.0.ms,
                duration: 600.0.ms,
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
              ),
            ],
      ),
    });
    setupAnimations(
      animationsMap.values.where(
        (anim) =>
            anim.trigger == AnimationTrigger.onActionTrigger ||
            !anim.applyInitialState,
      ),
      this,
    );
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
        backgroundColor: const Color(0xFFE5F1F1),
        body: SafeArea(
          top: true,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                
                PageView(
                  controller:
                      _model.pageViewController ??= PageController(
                        initialPage: 0,
                      ),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: const BoxDecoration(color: Color(0xFFE5F1F1)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset(
                              'assets/images/newsletter.png',
                              width: double.infinity,
                              height: 500.0,
                              fit: BoxFit.contain,
                            ).animateOnPageLoad(
                              animationsMap['imageOnPageLoadAnimation1']!,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'God\'s Word for Today',
                                    style: FlutterFlowTheme.of(
                                      context,
                                    ).headlineMedium.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(
                                            context,
                                          ).headlineMediumFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                            FlutterFlowTheme.of(
                                              context,
                                            ).headlineMediumFamily,
                                          ),
                                    ),
                                  ).animateOnPageLoad(
                                    animationsMap['textOnPageLoadAnimation1']!,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          15.0,
                                          0.0,
                                          0.0,
                                        ),
                                    child: Text(
                                      'Get personalized emails of articles from God\'s word in our newsletter',
                                      style: FlutterFlowTheme.of(
                                        context,
                                      ).labelMedium.override(
                                        fontFamily:
                                            FlutterFlowTheme.of(
                                              context,
                                            ).labelMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                              FlutterFlowTheme.of(
                                                context,
                                              ).labelMediumFamily,
                                            ),
                                      ),
                                    ).animateOnPageLoad(
                                      animationsMap['textOnPageLoadAnimation2']!,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          0.0,
                                          24.0,
                                          0.0,
                                          0.0,
                                        ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 30.0,
                                          borderWidth: 1.0,
                                          buttonSize: 60.0,
                                          icon: Icon(
                                            Icons.navigate_next_rounded,
                                            color:
                                                FlutterFlowTheme.of(
                                                  context,
                                                ).primary,
                                            size: 30.0,
                                          ),
                                          onPressed: () async {
                                            await _model.pageViewController
                                                ?.nextPage(
                                                  duration: const Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  curve: Curves.ease,
                                                );
                                          },
                                        ).animateOnPageLoad(
                                          animationsMap['iconButtonOnPageLoadAnimation1']!,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: const BoxDecoration(color: Color(0xFFE5F1F1)),
                      child: Wrap(
                        spacing: 0.0,
                        runSpacing: 0.0,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image.asset(
                                  'assets/images/Screenshot_2023-11-08_at_21.25.56.png',
                                  width: 395.0,
                                  height: 500.0,
                                  fit: BoxFit.cover,
                                ).animateOnPageLoad(
                                  animationsMap['imageOnPageLoadAnimation2']!,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Magazines',
                                        style: FlutterFlowTheme.of(
                                          context,
                                        ).headlineMedium.override(
                                          fontFamily:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).headlineMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                FlutterFlowTheme.of(
                                                  context,
                                                ).headlineMediumFamily,
                                              ),
                                        ),
                                      ).animateOnPageLoad(
                                        animationsMap['textOnPageLoadAnimation3']!,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              0.0,
                                              12.0,
                                              0.0,
                                              0.0,
                                            ),
                                        child: Text(
                                          'Study faith-inspiring messages in our magazine anytime and anywhere. ',
                                          style: FlutterFlowTheme.of(
                                            context,
                                          ).labelMedium.override(
                                            fontFamily:
                                                FlutterFlowTheme.of(
                                                  context,
                                                ).labelMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).labelMediumFamily,
                                                ),
                                          ),
                                        ).animateOnPageLoad(
                                          animationsMap['textOnPageLoadAnimation4']!,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                              0.0,
                                              24.0,
                                              0.0,
                                              0.0,
                                            ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30.0,
                                              borderWidth: 1.0,
                                              buttonSize: 60.0,
                                              icon: Icon(
                                                Icons.navigate_next_rounded,
                                                color:
                                                    FlutterFlowTheme.of(
                                                      context,
                                                    ).primary,
                                                size: 30.0,
                                              ),
                                              onPressed: () async {
                                                await _model.pageViewController
                                                    ?.nextPage(
                                                      duration: const Duration(
                                                        milliseconds: 300,
                                                      ),
                                                      curve: Curves.ease,
                                                    );
                                              },
                                            ).animateOnPageLoad(
                                              animationsMap['iconButtonOnPageLoadAnimation2']!,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 0.0,
                      runSpacing: 0.0,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: FlutterFlowExpandedImageView(
                                        image: Image.asset(
                                          'assets/images/Faith-In-Gods-Anointed-UPDATE-800x800.png',
                                          fit: BoxFit.contain,
                                        ),
                                        allowRotation: false,
                                        tag: 'imageTag3',
                                        useHeroAnimation: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: 'imageTag3',
                                  transitionOnUserGestures: true,
                                  child: Image.asset(
                                    'assets/images/Faith-In-Gods-Anointed-UPDATE-800x800.png',
                                    width: double.infinity,
                                    height: 500.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ).animateOnPageLoad(
                                animationsMap['imageOnPageLoadAnimation3']!,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Faith In God\'s Anointed',
                                      style: FlutterFlowTheme.of(
                                        context,
                                      ).headlineMedium.override(
                                        fontFamily:
                                            FlutterFlowTheme.of(
                                              context,
                                            ).headlineMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                              FlutterFlowTheme.of(
                                                context,
                                              ).headlineMediumFamily,
                                            ),
                                      ),
                                    ).animateOnPageLoad(
                                      animationsMap['textOnPageLoadAnimation5']!,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0.0,
                                            12.0,
                                            0.0,
                                            0.0,
                                          ),
                                      child: Text(
                                        'Access Books written by Rev. Chukie Morsi ',
                                        style: FlutterFlowTheme.of(
                                          context,
                                        ).labelMedium.override(
                                          fontFamily:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).labelMediumFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                FlutterFlowTheme.of(
                                                  context,
                                                ).labelMediumFamily,
                                              ),
                                        ),
                                      ).animateOnPageLoad(
                                        animationsMap['textOnPageLoadAnimation6']!,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0.0,
                                            24.0,
                                            0.0,
                                            0.0,
                                          ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 30.0,
                                            borderWidth: 1.0,
                                            buttonSize: 60.0,
                                            icon: Icon(
                                              Icons.navigate_next_rounded,
                                              color:
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).secondaryText,
                                              size: 30.0,
                                            ),
                                            onPressed: () async {
                                              await _model.pageViewController
                                                  ?.nextPage(
                                                    duration: const Duration(
                                                      milliseconds: 300,
                                                    ),
                                                    curve: Curves.ease,
                                                  );
                                            },
                                          ).animateOnPageLoad(
                                            animationsMap['iconButtonOnPageLoadAnimation3']!,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        // Removed color to prevent it from hiding the background image
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.network(
                            'https://res.cloudinary.com/dsohqp4d9/image/upload/v1749256564/Screenshot_7-6-2025_13449_www.freepik.com_cglesu.jpg',
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.broken_image, size: 100, color: Colors.grey),
                              );
                            },
                          ).image,
                        ),
                      ),
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE5F1F1),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Your Faith Journey Begins',
                                  style: FlutterFlowTheme.of(
                                    context,
                                  ).headlineMedium.override(
                                    fontFamily:
                                        FlutterFlowTheme.of(
                                          context,
                                        ).headlineMediumFamily,
                                    color: const Color(0xFF1E1E1E),
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                          FlutterFlowTheme.of(
                                            context,
                                          ).headlineMediumFamily,
                                        ),
                                  ),
                                ).animateOnPageLoad(
                                  animationsMap['textOnPageLoadAnimation7']!,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0,
                                    12.0,
                                    24.0,
                                    0.0,
                                  ),
                                  child: Text(
                                    'Sign up to get started!',
                                    style: FlutterFlowTheme.of(
                                      context,
                                    ).titleSmall.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(
                                            context,
                                          ).titleSmallFamily,
                                      color: const Color(0xFF1E1E1E),
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                            FlutterFlowTheme.of(
                                              context,
                                            ).titleSmallFamily,
                                          ),
                                    ),
                                  ).animateOnPageLoad(
                                    animationsMap['textOnPageLoadAnimation8']!,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    44.0,
                                    0.0,
                                    0.0,
                                  ),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      context.pushNamed('auth_2_Login');
                                    },
                                    text: 'Get Started',
                                    options: FFButtonOptions(
                                      width: 200.0,
                                      height: 50.0,
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                          ),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                            0.0,
                                            0.0,
                                            0.0,
                                            0.0,
                                          ),
                                      color: const Color(0xFF309C96),
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
                                      elevation: 2.0,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                  ).animateOnPageLoad(
                                    animationsMap['buttonOnPageLoadAnimation']!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation']!,
                    ),
                  ],
                ),
                Align(
                  alignment: const AlignmentDirectional(-0.85, 0.85),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      0.0,
                      0.0,
                      10.0,
                    ),
                    child: smooth_page_indicator.SmoothPageIndicator(
                      controller:
                          _model.pageViewController ??= PageController(
                            initialPage: 0,
                          ),
                      count: 4,
                      axisDirection: Axis.horizontal,
                      onDotClicked: (i) async {
                        await _model.pageViewController!.animateToPage(
                          i,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                        safeSetState(() {});
                      },
                      effect: smooth_page_indicator.ExpandingDotsEffect(
                        expansionFactor: 2.0,
                        spacing: 8.0,
                        radius: 16.0,
                        dotWidth: 16.0,
                        dotHeight: 4.0,
                        dotColor: FlutterFlowTheme.of(context).primary,
                        activeDotColor: FlutterFlowTheme.of(context).primary,
                        paintStyle: PaintingStyle.fill,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(1.0, -1.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24.0, right: 24.0),
                    child: TextButton(
                      onPressed: () {
                        context.pushNamed('auth_2_Login');
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Color(0xFF309C96),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
