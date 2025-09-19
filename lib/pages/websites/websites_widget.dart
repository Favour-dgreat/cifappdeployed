import 'package:Cefmorsi/account_profile_creation/auth_2_edit_profile/auth2_edit_profile_widget.dart';
import 'package:Cefmorsi/components/profile_info_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'websites_model.dart';
import 'package:http/http.dart' as http;

export 'websites_model.dart';

class WebsitesWidget extends StatefulWidget {
  const WebsitesWidget({super.key});

  @override
  State<WebsitesWidget> createState() => _WebsitesWidgetState();
}

class _WebsitesWidgetState extends State<WebsitesWidget> {
  late WebsitesModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<dynamic>>? futureData;
  int _currentIndex = 3; // 'More' tab is selected by default

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WebsitesModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
    futureData = fetchWebsitesData();
  }

  Future<List<dynamic>> fetchWebsitesData() async {
    final response = await http
        .get(Uri.parse('https://api-hqof2ayjqq-uc.a.run.app/websites'));
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
      throw Exception('Failed to load Websites data');
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
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                  ]
                ),
              ),
              Padding(
                padding:
                const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 30.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 0.0, 0.0),
                      child: FutureBuilder<List<dynamic>>(
                        future: futureData,
                        builder: (context, snapshot) {
                          return FFButtonWidget(
                            onPressed: () {},
                            text: 'Websites (${snapshot.data?.length ?? 0})',
                            options: FFButtonOptions(
                              width: 139.0,
                              height: 42.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              color: const Color(0xFFD4E9E8),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: FlutterFlowTheme.of(context).primary,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap()
                                    .containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleSmallFamily),
                              ),
                              elevation: 4.0,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          );
                        },
                      ),
                    ),
                  ].addToStart(const SizedBox(width: 10.0)),
                ),
              ),
              Expanded(
                child: buildWebsiteLists(() => fetchWebsitesData()),
              ),
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
        context.goNamed('Events');
        break;
          case 2:
        context.goNamed('Books');
        break;
          case 3:
        context.goNamed('Magazines');
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
            icon: Icon(Icons.podcasts_sharp),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Magazines',
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

  Widget buildWebsiteLists(Future<List<dynamic>> Function() fetchWebsitesData) {
    return FutureBuilder<List<dynamic>>(
      future: fetchWebsitesData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: SizedBox(
                  width: 40, height: 40, child: CircularProgressIndicator()));
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
            final websites = snapshot.data![index];
            return buildWebsiteItems(context, websites);
          },
        );
      },
    );
  }

  Widget buildWebsiteItems(BuildContext context, dynamic websites) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5.0,
              color: Color(0xFFF6F5F5),
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo Container
              Container(
                width: 70.0,
                height: 70.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // Add white background color
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    websites['image'], // Replace with book logo URL
                    fit: BoxFit.cover,
                    width: 80.0,
                    height: 80.0,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              // Text Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final url = websites[
                        'link']; // Replace with the URL from the API
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url),
                              mode: LaunchMode.externalApplication);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Text(
                        websites['title'], // Replace with website title
                        style:
                        FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: FlutterFlowTheme.of(context)
                              .headlineSmallFamily,
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          color: Color(
                              0xFF309C96), // Indicate it's a clickable link
                          decoration: TextDecoration
                              .underline, // Add underline for link style
                          useGoogleFonts: GoogleFonts.asMap()
                              .containsKey(FlutterFlowTheme.of(context)
                              .headlineSmallFamily),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      websites[
                      'summary'], // Replace with book description or subtitle
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                        FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontSize: 16.0,
                        color: Colors.grey,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
