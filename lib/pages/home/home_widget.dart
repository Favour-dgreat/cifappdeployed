import 'dart:async';
import 'package:in_app_update/in_app_update.dart'; 

import 'package:Cefmorsi/flutter_flow/flutter_flow_util.dart';
import 'package:Cefmorsi/pages/magazines/magazines_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Cefmorsi/account_profile_creation/auth_2_edit_profile/auth2_edit_profile_widget.dart';
import 'package:Cefmorsi/account_profile_creation/more/more_widget.dart';
import 'package:Cefmorsi/auth/firebase_auth/auth_util.dart';
import 'package:Cefmorsi/flutter_flow/flutter_flow_icon_button.dart';
import 'package:Cefmorsi/flutter_flow/flutter_flow_theme.dart';
import 'package:Cefmorsi/pages/book_details/book_details_widget.dart';
import 'package:Cefmorsi/pages/books/books_widget.dart';
import 'package:Cefmorsi/pages/events/events_widget.dart';
import 'package:Cefmorsi/pages/magazines_details/magazines_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;

final sliderCacheManager = CacheManager(
  Config(
    'sliderImagesCache', // Unique key for cache
    stalePeriod: const Duration(days: 7), // Keep cache for 7 days
    maxNrOfCacheObjects: 100, // Store up to 100 images
    repo: JsonCacheInfoRepository(databaseName: 'cached_images'),
    fileService: HttpFileService(),
  ),
);

final booksCacheManager = CacheManager(
  Config(
    'booksImagesCache', // Unique key for cache
    stalePeriod: const Duration(days: 7), // Keep cache for 7 days
    maxNrOfCacheObjects: 100, // Store up to 100 images
    repo: JsonCacheInfoRepository(databaseName: 'cached_images'),
    fileService: HttpFileService(),
  ),
);
final magazinesCacheManager = CacheManager(
  Config(
    'magazinesImagesCache', // Unique key for cache
    stalePeriod: const Duration(days: 7), // Keep cache for 7 days
    maxNrOfCacheObjects: 100, // Store up to 100 images
    repo: JsonCacheInfoRepository(databaseName: 'cached_images'),
    fileService: HttpFileService(),
  ),
);

final eventsCacheManager = CacheManager(
  Config(
    'eventsImagesCache', // Unique key for cache
    stalePeriod: const Duration(days: 7), // Keep cache for 7 days
    maxNrOfCacheObjects: 100, // Store up to 100 images
    repo: JsonCacheInfoRepository(databaseName: 'cached_images'),
    fileService: HttpFileService(),
  ),
);

class HomeWidget extends StatefulWidget {
  static const String routeName = '/home';

  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}
class HomeWidgetModel extends FlutterFlowModel {
  String uploadedFileUrl = '';

  HomeWidgetModel();

  @override
  void dispose() {
    // Clean up if necessary
  }
  
  @override
  void initState(BuildContext context) {
    // TODO: implement initState
  }
}
Future<void> checkForUpdate(BuildContext context) async {
  try {
    final info = await InAppUpdate.checkForUpdate();

    if (info.updateAvailability == UpdateAvailability.updateAvailable) {
      if (info.immediateUpdateAllowed) {
        await InAppUpdate.performImmediateUpdate();
      } else if (info.flexibleUpdateAllowed) {
        // Show dialog to user
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Update Available'),
              content: const Text('A new version of the app is available. Would you like to update now?'),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(ctx).pop();
                    final result = await InAppUpdate.startFlexibleUpdate();
                    if (result == AppUpdateResult.success && context.mounted) {
                      await InAppUpdate.completeFlexibleUpdate();
                      showDialog(
                        context: context,
                        builder: (ctx2) => AlertDialog(
                          title: const Text('Update Ready'),
                          content: const Text('The update has been downloaded. The app will now restart to apply the update.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx2).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Update'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Later'),
                ),
              ],
            ),
          );
        }
      }
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Update check failed: $e")),
      );
    }
  }
}
class _HomeWidgetState extends State<HomeWidget> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<dynamic>> futureData;
  late PageController _sliderController;
  List<dynamic> sliderItems = [];
  int _currentIndex = 0;

  late Timer _timer;
  late HomeWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeWidgetModel());

    // Initialize the slider controller
    _sliderController = PageController();

    // Fetch slider data
    futureData = fetchSliderData().then((data) {
      setState(() {
        sliderItems = data;
      });
      return data;
    });
  

    // Auto-slide every 6 seconds
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (_sliderController.hasClients) {
        int nextPage = (_sliderController.page?.toInt() ?? 0) + 1;
        if (nextPage >= sliderItems.length) {
          nextPage = 0; // Reset to the first page
        }
        _sliderController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
WidgetsBinding.instance.addPostFrameCallback((_) {
    checkForUpdate(context);
  });  
  }

  Future<List<dynamic>> fetchSliderData() async {
    final response = await http.get(
      Uri.parse('https://api-hqof2ayjqq-uc.a.run.app/slider'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load slider data');
    }
  }

  @override
  void dispose() {
    _sliderController.dispose();
    _timer.cancel();
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
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
        ClipRRect(
          child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFFF1F4F8)),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
          child: Wrap(
        spacing: 8,
        runSpacing: 4,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        direction: Axis.horizontal,
        runAlignment: WrapAlignment.start,
        verticalDirection: VerticalDirection.down,
        clipBehavior: Clip.antiAlias,
        children: [
          Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          16,
          0,
          16,
          0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Hi'),
            Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
          2,
          0,
          0,
          0,
          ),
          child: AuthUserStreamWidget(
          builder: (context) {
            final displayName = (currentUserDisplayName != null && currentUserDisplayName.isNotEmpty)
          ? currentUserDisplayName
          : 'Guest';
            return Text(
            '$displayName,',
            style: const TextStyle(
          fontWeight: FontWeight.bold,
            ),
            );
          },
          ),
            ),
          ],
            ),
            Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
          color: const Color(0xFF309C96),
          width: 2,
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
            (_model.uploadedFileUrl.isNotEmpty)
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
          FutureBuilder<List<dynamic>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
          ConnectionState.waiting) {
            return const Center(
          child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
          child: Text('Failed to load data'),
            );
          } else if (!snapshot.hasData ||
          snapshot.data!.isEmpty) {
            return const Center(
          child: Text('No data available'),
            );
          }

          List<dynamic> sliderItems = snapshot.data!;
          return Column(
            children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
          controller: _sliderController,
          itemCount: sliderItems.length,
          itemBuilder: (context, index) {
            final sliderItem = sliderItems[index];
            return buildSliderItem(context, sliderItem);
          },
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: const AlignmentDirectional(0, 1),
            child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            0,
            0,
            0,
            10,
          ),
          child: smooth_page_indicator.SmoothPageIndicator(
            controller: _sliderController,
            count: sliderItems.length,
            axisDirection: Axis.horizontal,
            onDotClicked: (i) async {
          await _sliderController.animateToPage(
            i,
            duration: const Duration(
          milliseconds: 200,
            ),
            curve: Curves.ease,
          );
          setState(() {});
            },
            effect:
            const smooth_page_indicator.ExpandingDotsEffect(
          expansionFactor: 2,
          spacing: 8,
          radius: 16,
          dotWidth: 8,
          dotHeight: 4,
          dotColor: Color(0xFF57636C),
          activeDotColor: Color(0xFF309C96),
          paintStyle: PaintingStyle.fill,
            ),
          ),
            ),
            ),

            const SizedBox(height: 20),
            // Upcoming Event Banner with Countdown
            FutureBuilder<List<dynamic>>(
              future: fetchEventsData(),
              builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                return const SizedBox.shrink();
              }

              // Find the next upcoming event (with a valid future date)
              final now = DateTime.now();
              final upcomingEvents = snapshot.data!
                .where((event) {
                  if (event['date'] == null) return false;
                  try {
                  final eventDate = DateTime.parse(event['date']);
                  return eventDate.isAfter(now);
                  } catch (_) {
                  return false;
                  }
                })
                .toList();

              if (upcomingEvents.isEmpty) {
                return const SizedBox.shrink();
              }

              final event = upcomingEvents.first;
              final eventDate = DateTime.parse(event['date']);
              final zoomLink = event['zoom_link'] ?? '';

              return UpcomingEventBanner(
                title: event['title'] ?? 'Upcoming Event',
                dateTime: eventDate,
                imageUrl: event['image'] ?? '',
                zoomLink: zoomLink,
                location: event['location'] ?? '',
              );
              },
            ),
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 233, 236, 241), // Light shade background
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Vertical line, height matches the text+subtitle
                    Container(
                      width: 3,
                      height: 44, // Adjusted to match the combined height of both texts
                      color: const Color(0xFF309C96),
                      margin: const EdgeInsets.only(right: 12, top: 2),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Texts
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Latest Magazines",
                                  style: TextStyle(
                                    color: Color(0xFF309C96),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Read inspiring and life-transforming magazines",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF57636C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Button
                          SizedBox(
                            width: 110,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF309C96)),
                                foregroundColor: const Color(0xFF309C96),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MagazinesWidget(),
                                    settings: const RouteSettings(name: 'Magazines'),
                                  ),
                                );
                              },
                              child: const Text(
                                "View All",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
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
            // ...existing code...
          buildMagazineList(),
          const SizedBox(height: 20),
          Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 233, 236, 241), // Light shade background
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Vertical line, height matches the text+subtitle
                    Container(
                      width: 3,
                      height: 44, // Adjusted to match the combined height of both texts
                      color: const Color(0xFF309C96),
                      margin: const EdgeInsets.only(right: 12, top: 2),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Texts
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Latest Books",
                                  style: TextStyle(
                                    color: Color(0xFF309C96),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Books by Pastor Chukie Morsi",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF57636C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Button
                          SizedBox(
                            width: 110,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF309C96)),
                                foregroundColor: const Color(0xFF309C96),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BooksWidget(),
                                    settings: const RouteSettings(name: 'Books'),
                                  ),
                                );
                              },
                              child: const Text(
                                "View All",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
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
          buildBookList(),
          const SizedBox(height: 20),
          Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 233, 236, 241), // Light shade background
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Vertical line, height matches the text+subtitle
                    Container(
                      width: 3,
                      height: 44, // Adjusted to match the combined height of both texts
                      color: const Color(0xFF309C96),
                      margin: const EdgeInsets.only(right: 12, top: 2),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Texts
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Recent Events",
                                  style: TextStyle(
                                    color: Color(0xFF309C96),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Don't miss our Bible Study, Bible Teaching and Prayer Meetings",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF57636C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Button
                          SizedBox(
                            width: 110,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF309C96)),
                                foregroundColor: const Color(0xFF309C96),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EventsWidget(),
                                    settings: const RouteSettings(name: 'Events'),
                                  ),
                                );
                              },
                              child: const Text(
                                "View All",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
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
          buildEventLists(),
            ],
          );
        },
          ),
        ],
          ),
        ),
          ],
        ),
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

Widget buildSliderItem(BuildContext context, dynamic sliderItem) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        height: 251,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            const BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 6.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: sliderItem['image'] ?? '',
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.contain,
                cacheManager: sliderCacheManager, // Use custom cache manager
                placeholder:
                    (context, url) => Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.4,
                      color: Colors.grey[300], // Placeholder color
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                errorWidget:
                    (context, url, error) =>
                        const Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      elevation: WidgetStatePropertyAll(3),
                      padding: WidgetStatePropertyAll(
                        EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Color(0xFF309C96),
                      ),
                    ),
                    child: Text(sliderItem['category']),
                  ),
                  Text(
                    sliderItem['title'] ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
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

Future<List<dynamic>> fetchBookData() async {
  final response = await http.get(
    Uri.parse('https://api-hqof2ayjqq-uc.a.run.app/books'),
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load books');
  }
}

Widget buildBookList() {
  return FutureBuilder<List<dynamic>>(
    future: fetchBookData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Skeleton loader for books
        return SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Number of skeleton items
            itemBuilder: (context, index) {
              return buildSkeletonCard();
            },
          ),
        );
      } else if (snapshot.hasError) {
        return const Center(child: Text('Failed to load data'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No data available'));
      }

      return SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final book = snapshot.data![index];
            return buildBookItem(context, book);
          },
        ),
      );
    },
  );
}

Widget buildBookItem(BuildContext context, dynamic book) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: InkWell(
          onTap: () async {
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: book['image'] ?? '',
                  fit: BoxFit.contain,
                  cacheManager: booksCacheManager, // Use custom cache manager
                  placeholder:
                      (context, url) => Container(
                        color: Colors.grey[300], // Placeholder color
                      ),
                  errorWidget:
                      (context, url, error) =>
                          const Icon(Icons.broken_image, size: 100),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity, // Span across the card width
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Center the text
                      children: [
                        Text(
                          book['title'] ?? 'No Title',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'By ${book['author'] ?? 'Unknown'}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Future<List<dynamic>> fetchMagazineData() async {
  final response = await http.get(
    Uri.parse('https://api-hqof2ayjqq-uc.a.run.app/magazines'),
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load magazines');
  }
}

Widget buildMagazineList() {
  return FutureBuilder<List<dynamic>>(
    future: fetchMagazineData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Skeleton loader for magazines
        return SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Number of skeleton items
            itemBuilder: (context, index) {
              return buildSkeletonCard();
            },
          ),
        );
      } else if (snapshot.hasError) {
        return const Center(child: Text('Failed to load data'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No data available'));
      }

      return SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final magazine = snapshot.data![index];
            return buildMagazineItem(context, magazine);
          },
        ),
      );
    },
  );
}

Widget buildSkeletonCard() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
  );
}

Widget buildMagazineItem(BuildContext context, dynamic magazine) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: InkWell(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => MagazinesDetailsWidget(
                      title: magazine['title'],
                      author: magazine['author'],
                      summary: magazine['summary'],
                      imageUrl: magazine['image'],
                      link: magazine['link'],
                    ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: magazine['image'] ?? '',
                  fit: BoxFit.cover,
                  cacheManager:
                      magazinesCacheManager, // Use custom cache manager
                  placeholder:
                      (context, url) => Container(
                        color: Colors.grey[300], // Placeholder color
                      ),
                  errorWidget:
                      (context, url, error) =>
                          const Icon(Icons.broken_image, size: 100),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity, // Span across the card width
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Center the text
                      children: [
                        Text(
                          magazine['title'] ?? 'No Title',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'By ${magazine['author'] ?? 'Unknown'}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Future<List<dynamic>> fetchEventsData() async {
  final response = await http.get(
    Uri.parse('https://api-hqof2ayjqq-uc.a.run.app/events'),
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load events');
  }
}

Widget buildEventLists() {
  return FutureBuilder<List<dynamic>>(
    future: fetchEventsData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Skeleton loader for events
        return SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Number of skeleton items
            itemBuilder: (context, index) {
              return buildSkeletonCard();
            },
          ),
        );
      } else if (snapshot.hasError) {
        return const Center(child: Text('Failed to load data'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No data available'));
      }

      return SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final event = snapshot.data![index];
            return buildEventItems(context, event);
          },
        ),
      );
    },
  );
}

class UpcomingEventBanner extends StatefulWidget {
  final String title;
  final DateTime dateTime;
  final String imageUrl;
  final String zoomLink;
  final String location;

  const UpcomingEventBanner({
    Key? key,
    required this.title,
    required this.dateTime,
    required this.imageUrl,
    required this.zoomLink,
    required this.location,
  }) : super(key: key);

  @override
  State<UpcomingEventBanner> createState() => _UpcomingEventBannerState();
}

class _UpcomingEventBannerState extends State<UpcomingEventBanner> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = widget.dateTime.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final diff = widget.dateTime.difference(DateTime.now());
      if (diff.isNegative) {
        _timer.cancel();
      }
      setState(() {
        _remaining = diff;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    if (duration.isNegative) return "Started";
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return "${days}d ${hours}h ${minutes}m ${seconds}s";
  }

  @override
  Widget build(BuildContext context) {
    // Add a scale animation to attract attention
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0, end: 1.05),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      builder: (context, scale, child) {
      return Transform.scale(
        scale: scale,
        child: child,
      );
      },
      onEnd: () {
      // Optionally, you can reverse the animation for a pulse effect
      // setState(() {});
      },
      child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 6,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 200, // Increased card height
        child: Stack(
        children: [
          // Background image
          widget.imageUrl.isNotEmpty
            ? CachedNetworkImage(
              imageUrl: widget.imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            )
            : Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[300],
              child: const Icon(Icons.event, size: 60, color: Colors.white70),
            ),
          // Overlay
          Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              const Color(0xFF309C96).withOpacity(0.50),
              const Color(0xFF309C96).withOpacity(0.60),
              Colors.transparent,
            ],
            stops: const [0.0, 0.6, 1.0],
            ),
          ),
          ),
          // Content
          Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
              "Upcoming Event",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                shadows: [
                  Shadow(
                    color: Colors.black38,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              ),
              Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                shadows: [
                Shadow(
                  color: Colors.black38,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Location
              Row(
              children: [
                const Icon(Icons.location_pin, color: Colors.white, size: 18),
                const SizedBox(width: 4),
                Expanded(
                child: Text(
                  widget.location,
                  style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                ),
              ],
              ),
              const SizedBox(height: 2),
              // Countdown
              Row(
              children: [
                const Icon(Icons.timer, color: Colors.white, size: 18),
                const SizedBox(width: 4),
                Text(
                formatDuration(_remaining),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                ),
              ],
              ),
              const Spacer(),
              // Zoom button
              if (widget.zoomLink.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  backgroundColor: Colors.white.withOpacity(0.08),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
                icon: const Icon(Icons.link, color: Colors.white, size: 18),
                label: const Text(
                  "Join Zoom",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  await launchURL(widget.zoomLink);
                },
                ),
              ),
            ],
            ),
          ),
          ),
        ],
        ),
      ),
      ),
    );
  }
}

Widget buildEventItems(BuildContext context, dynamic event) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: InkWell(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EventsWidget()),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: event['image'] ?? '',
                  fit: BoxFit.cover,
                  cacheManager: eventsCacheManager, // Use custom cache manager
                  placeholder:
                      (context, url) => Container(
                        color: Colors.grey[300], // Placeholder color
                      ),
                  errorWidget:
                      (context, url, error) =>
                          const Icon(Icons.broken_image, size: 100),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity, // Span across the card width
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Center the text
                      children: [
                        Text(
                          event['title'] ?? 'No Title',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.white,
                          ),
                        ),
                        Text(
                          event['frequency'] ?? 'No Date',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                8,
                                0,
                                0,
                                0,
                              ),
                              child: Icon(
                                Icons.punch_clock,
                                color: Color(0xFF309C96),
                                size: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                0,
                                5,
                                0,
                                0,
                              ),
                              child: Text(
                                event['time'] ?? 'No Time',
                                style: const TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 0.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8), // Add spacing
                        const Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                8,
                                0,
                                0,
                                0,
                              ),

                            ),

                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
