import 'package:Cefmorsi/components/profile_info_widget.dart';

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
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'events_model.dart';
export 'events_model.dart';
import 'package:shimmer/shimmer.dart';

class EventsWidget extends StatefulWidget {
  static String routeName = '/EventsWidget';

  const EventsWidget({super.key});

  @override
  State<EventsWidget> createState() => _EventsWidgetState();
}
class EventsModel extends FlutterFlowModel {
  String uploadedFileUrl = '';

  EventsModel();

  @override
  void dispose() {
    // Clean up if necessary
  }
  
  @override
  void initState(BuildContext context) {
    // TODO: implement initState
  }
}
class _EventsWidgetState extends State<EventsWidget> {
  late EventsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<dynamic>>? futureData;
  int _currentIndex = 3; // Events tab is selected by default

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventsModel());
    futureData = fetchEventsData();
  }

  Future<List<dynamic>> fetchEventsData() async {
    final response = await http.get(
      Uri.parse('https://api-hqof2ayjqq-uc.a.run.app/events'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic> && data.containsKey('items')) {
        return List<dynamic>.from(data['items']);
      }

      if (data is List<dynamic>) {
        return data;
      }

      throw Exception('Unexpected data format');
    } else {
      throw Exception('Failed to load Events data');
    }
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
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
                                          alignment: const AlignmentDirectional(
                                            0,
                                            0,
                                          ).resolve(Directionality.of(context)),
                                          child: Container(
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
                                              child: const ProfileInfoWidget(),
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
                                padding: const EdgeInsets.all(2),
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
                                                        _model.uploadedFileUrl.isNotEmpty)
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
                  ].addToStart(const SizedBox(height: 10.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  0.0,
                  20.0,
                  0.0,
                  0.0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        text: 'Upcoming Events',
                        options: FFButtonOptions(
                          width: 218.0,
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
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).titleSmallFamily,
                            ),
                          ),
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ].addToStart(const SizedBox(width: 30.0)),
                ),
              ),

              Expanded(child: buildEventLists(() => fetchEventsData())),
              const SizedBox(height: 10.0),
              
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

Widget buildEventLists(Future<List<dynamic>> Function() fetchEventsData) {
  return FutureBuilder<List<dynamic>>(
    future: fetchEventsData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9, // Reduce width (90% of screen)
          height: MediaQuery.sizeOf(context).height * 0.26, // Increased height for the card
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 3, // Number of skeleton items
            itemBuilder: (context, index) {
              return buildSkeletonCard(context);
            },
          ),
        );
      } else if (snapshot.hasError) {
        return const Center(child: Text('Failed to load data'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No data available'));
      }

      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final event = snapshot.data![index];
          return buildEventItems(context, event);
        },
      );
    },
  );
}

Widget buildSkeletonCard(BuildContext context) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 5),
    child: Material(
      color: Colors.transparent,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), // Match real card radius
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.9, // Match real card width
        height: MediaQuery.sizeOf(context).height * 0.26, // Match real card height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color(0xFFF6F5F5),
              offset: Offset(0, 2),
              spreadRadius: 1,
            ),
          ],
          color: Colors.grey[300], // Placeholder color for image
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24.0)),
              color: Colors.black.withOpacity(0.55),
            ),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title skeleton
                Container(
                  height: 24,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 4),
                // Frequency skeleton
                Container(
                  height: 18,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 8),
                // Row for time and location
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Time icon
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Time skeleton
                    Container(
                      height: 16,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Location icon
                    Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Location skeleton
                    Expanded(
                      child: Container(
                        height: 16,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildEventItems(BuildContext context, dynamic event) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 5),
    child: Material(
      color: Colors.transparent,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // More border radius
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.9, // Reduce width (90% of screen)
        height: MediaQuery.sizeOf(context).height * 0.26, // Increased height for the card
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), // More border radius
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color(0xFFF6F5F5),
              offset: Offset(0, 4),
              spreadRadius: 4,
            ),
          ],
          image: event['image'] != null && event['image'].isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(event['image']),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24.0)),
              color: Colors.black.withOpacity(0.55), // semi-transparent overlay
            ),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        event['title'] ?? 'No Title',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    FFButtonWidget(
                      icon: const FaIcon(
                        FontAwesomeIcons.solidCirclePlay,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: () {
                        launchURL('https://www.youtube.com/playlist?list=PLUJ-s9j9uwfmk3Lw6GDCMGaJ5dMQug5Pu');
                      },
                      text: 'Watch Recording',
                      options: FFButtonOptions(
                        
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: Colors.white,
                          fontSize: 14,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                          ),
                        ),
                        elevation: 2,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  event['frequency'] ?? 'No Date',
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 0.0,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).bodySmallFamily,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.date_range_outlined,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      event['time'] ?? 'No Time',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                        fontSize: 16,
                        color: Colors.white,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).bodySmallFamily,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.location_pin,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 22,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        event['location'] ?? 'No Location',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodySmallFamily,
                          ),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
