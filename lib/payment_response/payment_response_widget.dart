import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentResponseWidget extends StatefulWidget {
  const PaymentResponseWidget({
    Key key,
    this.pTitle,
  }) : super(key: key);

  final String pTitle;

  @override
  _PaymentResponseWidgetState createState() => _PaymentResponseWidgetState();
}

class _PaymentResponseWidgetState extends State<PaymentResponseWidget> {
  ApiCallResponse oCallPayment3;
  dynamic oCreateAuth3;
  TextEditingController txtRequestIdController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    txtRequestIdController =
        TextEditingController(text: FFAppState().requestId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).tertiaryColor,
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.pTitle,
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: FlutterFlowTheme.of(context).tertiaryColor,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 24, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: txtRequestIdController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Request Id',
                            hintText: 'Enter payment request id',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primaryColor,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                            child: InkWell(
                              onTap: () async {
                                oCreateAuth3 = await actions.createAuth();
                                oCallPayment3 =
                                    await GetPtRequestInformationCall.call(
                                  login: getJsonField(
                                    oCreateAuth3,
                                    r'''$.auth.login''',
                                  ).toString(),
                                  tranKey: getJsonField(
                                    oCreateAuth3,
                                    r'''$.auth.tranKey''',
                                  ).toString(),
                                  nonce: getJsonField(
                                    oCreateAuth3,
                                    r'''$.auth.nonce''',
                                  ).toString(),
                                  seed: getJsonField(
                                    oCreateAuth3,
                                    r'''$.auth.seed''',
                                  ).toString(),
                                  requestId: txtRequestIdController.text,
                                );
                                setState(() => FFAppState().paymentStatus =
                                    (oCallPayment3?.jsonBody ?? ''));

                                setState(() {});
                              },
                              child: Icon(
                                Icons.send_rounded,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 24, 12, 0),
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primaryColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                            child: Text(
                              'Status: ${getJsonField(
                                FFAppState().paymentStatus,
                                r'''$.status.status''',
                              ).toString()}',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                            child: Text(
                              'Reason: ${getJsonField(
                                FFAppState().paymentStatus,
                                r'''$.status.reason''',
                              ).toString()}',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                            child: Text(
                              getJsonField(
                                FFAppState().paymentStatus,
                                r'''$.status.message''',
                              ).toString(),
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                            child: Text(
                              'Date: ${getJsonField(
                                FFAppState().paymentStatus,
                                r'''$.status.date''',
                              ).toString()}',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                        ],
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
