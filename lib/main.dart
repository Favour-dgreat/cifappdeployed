import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';  
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';
import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'index.dart';
import 'package:firebase_app_check/firebase_app_check.dart' as app_check;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Initialize Firebase and Firebase App Check first
  await Firebase.initializeApp();
  await app_check.FirebaseAppCheck.instance.activate(
    androidProvider: app_check.AndroidProvider.playIntegrity,
    appleProvider: app_check.AppleProvider.appAttest,
  );

  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();
    
  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));
}
  
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;
  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  
  Stream<BaseAuthUser>? userStream;
  StreamSubscription? authUserSub;
  bool _isSplashScreenVisible = true;

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    
    // Initialize Firebase Auth streams
    userStream = cefmorsiFirebaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    authUserSub = authenticatedUserStream.listen((_) {});
    jwtTokenStream.listen((_) {});
    
    _loadApp();
  }

  Future<void> _loadApp() async {
    // Simulate initialization delay or perform actual initialization tasks
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isSplashScreenVisible = false;
    });
  }

  @override
  void dispose() {
    authUserSub?.cancel();
    super.dispose();
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    if (_isSplashScreenVisible) {
      return const MaterialApp(
        home: SplashWidget(), 
      );
    }
    
    return MaterialApp.router(
      title: 'Cefmorsi',
      localizationsDelegates: const [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('pt'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}