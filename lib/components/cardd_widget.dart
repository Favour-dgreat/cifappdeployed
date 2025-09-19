import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cardd_model.dart';
export 'cardd_model.dart';

class CarddWidget extends StatefulWidget {
  const CarddWidget({super.key});

  @override
  State<CarddWidget> createState() => _CarddWidgetState();
}

class _CarddWidgetState extends State<CarddWidget> {
  late CarddModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarddModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 0.0, 0.0),
      child: Material(
        color: Colors.transparent,
        elevation: 4.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            width: 158.0,
            height: 149.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: const BorderRadius.only(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Church Life',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'League Spartan',
                          color: FlutterFlowTheme.of(context).primary,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('League Spartan'),
                          lineHeight: 2.0,
                        ),
                  ),
                  Text(
                    'Church Life',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'League Spartan',
                          letterSpacing: 0.0,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('League Spartan'),
                          lineHeight: 2.0,
                        ),
                  ),
                  Text(
                    'Church Life',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodySmallFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodySmallFamily),
                          lineHeight: 2.0,
                        ),
                  ),
                  Text(
                    'Church Life',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodySmallFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodySmallFamily),
                          lineHeight: 2.0,
                        ),
                  ),
                  Text(
                    'Church Life',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodySmallFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodySmallFamily),
                          lineHeight: 2.0,
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
}
