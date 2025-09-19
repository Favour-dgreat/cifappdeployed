import 'package:Cefmorsi/components/profile_info_widget.dart';
import 'package:Cefmorsi/pages/book_details/book_details_widget.dart';
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
import 'books_model.dart';
export 'books_model.dart';

class BooksWidget extends StatefulWidget {
  static String routeName = 'Books';
  static String routePath = 'books';
  const BooksWidget({super.key});

  @override
  State<BooksWidget> createState() => _BooksWidgetState();
}
class BooksModel extends FlutterFlowModel {
  String uploadedFileUrl = '';

 BooksModel();

  @override
  void dispose() {
    // Clean up if necessary
  }
  
  @override
  void initState(BuildContext context) {
    // TODO: implement initState
  }
}
class _BooksWidgetState extends State<BooksWidget> {
  late BooksModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<dynamic>>? futureData;
  int _currentIndex = 2; // Books tab is selected by default

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BooksModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));

    futureData = fetchBooksData();
  }

  Future<List<dynamic>> fetchBooksData() async {
    final response = await http.get(
      Uri.parse('https://api-hqof2ayjqq-uc.a.run.app/books'),
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
                      child: FutureBuilder<List<dynamic>>(
                        future: futureData,
                        builder: (context, snapshot) {
                          return FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Books (${snapshot.data?.length ?? 0})',
                            options: FFButtonOptions(
                              width: 121,
                              height: 42,
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
                                    FlutterFlowTheme.of(
                                      context,
                                    ).titleSmallFamily,
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
                          );
                        },
                      ),
                    ),
                  ].addToStart(const SizedBox(width: 30.0)),
                ),
              ),

              Expanded(child: buildBookLists(() => fetchBooksData())),
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

Widget buildBookLists(Future<List<dynamic>> Function() fetchBooksData) {
  return FutureBuilder<List<dynamic>>(
    future: fetchBooksData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
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
          final book = snapshot.data![index];
          return buildBookItems(context, book);
        },
      );
    },
  );
}

Widget buildBookItems(BuildContext context, dynamic book) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(8, 20, 8, 0),
    child: Material(
      color: Colors.transparent,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 345,
        height: 147,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            const BoxShadow(
              blurRadius: 5,
              color: Color(0xFFF6F5F5),
              offset: Offset(0.0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          shape: BoxShape.rectangle,
        ),
        child: Align(
          alignment: const AlignmentDirectional(0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book['image'] ?? '',
                  width: 158,
                  height: 144,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 30, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        book['title'] ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: FlutterFlowTheme.of(
                          context,
                        ).headlineSmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineSmallFamily,
                          color: FlutterFlowTheme.of(context).primary,
                          fontSize: 15,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).headlineSmallFamily,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        book['author'] ?? '',
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: const Color(0xFF57636C),
                          fontSize: 12,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w800,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                            'Plus Jakarta Sans',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        0,
                        10,
                        0,
                        0,
                      ),
                      child: FFButtonWidget(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BookDetailsWidget(
                                    title: book['title'],
                                    author: book['author'],
                                    summary: book['summary'],
                                    imageUrl: book['image'],
                                    link: book['link'],
                                  ),
                            ),
                          );
                        },
                        text: 'Read More',
                        options: FFButtonOptions(
                          height: 42,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            16,
                            0,
                            16,
                            0,
                          ),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0,
                            0,
                            0,
                            0,
                          ),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(
                            context,
                          ).titleSmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: Colors.white,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).titleSmallFamily,
                            ),
                          ),
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ].addToEnd(const SizedBox(width: 20)),
          ),
        ),
      ),
    ),
  );
}
