import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'events_card_model.dart';
export 'events_card_model.dart';

class EventsCardWidget extends StatefulWidget {
  const EventsCardWidget({super.key});

  @override
  State<EventsCardWidget> createState() => _EventsCardWidgetState();
}

class _EventsCardWidgetState extends State<EventsCardWidget> {
  late EventsCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventsCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Church Life',
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'League Spartan',
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        GoogleFonts.asMap().containsKey('League Spartan'),
                    lineHeight: 2.0,
                  ),
            ),
            Text(
              'Ministerial Outreaches',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'League Spartan',
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        GoogleFonts.asMap().containsKey('League Spartan'),
                    lineHeight: 2.0,
                  ),
            ),
            Text(
              'Charitable Causes',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'League Spartan',
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        GoogleFonts.asMap().containsKey('League Spartan'),
                    lineHeight: 2.0,
                  ),
            ),
            Text(
              'Online Meetings',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'League Spartan',
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        GoogleFonts.asMap().containsKey('League Spartan'),
                    lineHeight: 2.0,
                  ),
            ),
            Text(
              'African & Global Missions',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'League Spartan',
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        GoogleFonts.asMap().containsKey('League Spartan'),
                    lineHeight: 2.0,
                  ),
            ),
          ].addToStart(const SizedBox(height: 20.0)),
        ),
      ),
    );
  }
}
