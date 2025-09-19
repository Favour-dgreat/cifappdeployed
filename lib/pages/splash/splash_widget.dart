import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; 
import 'package:connectivity_plus/connectivity_plus.dart'; // for Connectivity
import '../../flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'splash_model.dart';
export 'splash_model.dart';
import 'package:flutter/foundation.dart'; // Import for kDebugMode
import 'dart:developer'; // Import for logging

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});
  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget>
    with TickerProviderStateMixin {
  late SplashModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashModel());

    // Perform internet connection test
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        if (mounted) {
          // No internet connection
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("This device is not connected to the internet"),
              duration: Duration(seconds: 3),
            ),
          );
        }

        // Close the app after showing the snackbar
        await Future.delayed(const Duration(seconds: 3));
        if (mounted) {
          exit(0); // Exit the app
        }
        return;
      }

      // Navigate to the onboarding screen after 10 seconds
      await Future.delayed(const Duration(seconds: 5));
      if (!mounted) return;

      log("Connectivity Result: $connectivityResult"); // Log the connectivity result

      context.pushNamed(
        'onboardingScreen',
        extra: <String, dynamic>{
          kTransitionInfoKey: const TransitionInfo(
            hasTransition: true,
            transitionType: PageTransitionType.fade,
            duration: Duration(milliseconds: 500),
          ),
        },
      );
    });

    animationsMap.addAll({
      'columnOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            delay: Duration.zero,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
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
        backgroundColor: const Color(0x6053D2CB),
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeInOut,
                  child: Container(
                    width: 153,
                    height: 152,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        'assets/images/cefmorsi.png',
                        height: 210,
                        fit: BoxFit.contain,
                      ),
                    ),
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