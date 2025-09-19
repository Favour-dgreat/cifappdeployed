import '../../flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Event_details_model.dart';
export 'Event_details_model.dart';

class EventDetailsWidget extends StatefulWidget {
  const EventDetailsWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.frequency,
    required this.summary,
    required this.link,
  });
  final String? imageUrl;
  final String? title;
  final String? frequency;
  final String? summary;
  final String? link;

  static String routeName = 'eventsDetails';
  static String routePath = 'eventsDetails';

  @override
  State<EventDetailsWidget> createState() => _EventDetailsWidgetState();
}

class _EventDetailsWidgetState extends State<EventDetailsWidget> {
  late EventDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 3; // Events tab is selected by default

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventDetailsModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: const Color(0xFFFCFCFC),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                        child: SafeArea(
                          child: ClipRRect(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: widget.imageUrl != null
                                      ? DecorationImage(
                                          image: NetworkImage(widget.imageUrl!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4), // Optional: overlay for readability
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            30.0, 0.0, 20.0, 20.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                FlutterFlowIconButton(
                                                  borderRadius: 8.0,
                                                  buttonSize: 30.0,
                                                  fillColor:
                                                      FlutterFlowTheme.of(context).primary,
                                                  icon: Icon(
                                                    Icons.arrow_back,
                                                    color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                    size: 15.0,
                                                  ),
                                                  onPressed: () async {
                                                    context.safePop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                ),
                              )

                          ),

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 15.0),
                            child: Text(
                              'Summary',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                                color: FlutterFlowTheme.of(context).primary,
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context).bodyMediumFamily),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                            child: Text(
                              valueOrDefault<String>(
                                widget.summary,
                                'This is a Summary',
                              ),
                              textAlign: TextAlign.justify,
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                                color: const Color(0xFF1E1E1E),
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context).bodyMediumFamily),
                                lineHeight: 2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await launchURL(widget.link!);
                              },
                              text: 'Order the Event ',
                              options: FFButtonOptions(
                                height: 40,
                                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                  fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                                      FlutterFlowTheme.of(context)
                                          .titleSmallFamily),
                                ),
                                elevation: 4.0,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomNavigationBar(
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
          ],
        ),
      ),
    );
  }
}
