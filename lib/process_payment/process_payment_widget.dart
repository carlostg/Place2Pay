import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_web_view.dart';
import '../custom_code/actions/index.dart' as actions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ProcessPaymentWidget extends StatefulWidget {
  const ProcessPaymentWidget({
    Key key,
    this.pTitle,
  }) : super(key: key);

  final String pTitle;

  @override
  _ProcessPaymentWidgetState createState() => _ProcessPaymentWidgetState();
}

class _ProcessPaymentWidgetState extends State<ProcessPaymentWidget> {
  ApiCallResponse oCallPayment2;
  dynamic oCreateAuth2;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ApiCallResponse oCallPayment;
  dynamic oPayload;
  TextEditingController tFTotalController;

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() => FFAppState().showAnimation = true);
      oCreateAuth2 = await actions.createAuth();
      oCallPayment2 = await CallPaymentCall.call(
        login: getJsonField(
          oCreateAuth2,
          r'''$.auth.login''',
        ).toString(),
        tranKey: getJsonField(
          oCreateAuth2,
          r'''$.auth.tranKey''',
        ).toString(),
        nonce: getJsonField(
          oCreateAuth2,
          r'''$.auth.nonce''',
        ).toString(),
        seed: getJsonField(
          oCreateAuth2,
          r'''$.auth.seed''',
        ).toString(),
        total: double.parse(tFTotalController.text),
        expiration: getJsonField(
          oCreateAuth2,
          r'''$.expiration''',
        ).toString(),
      );
      setState(() => FFAppState().payUrl = getJsonField(
            (oCallPayment2?.jsonBody ?? ''),
            r'''$.processUrl''',
          ).toString());
      setState(() => FFAppState().requestId = getJsonField(
            (oCallPayment2?.jsonBody ?? ''),
            r'''$.requestId''',
          ).toString());
      await Future.delayed(const Duration(milliseconds: 3000));
      setState(() => FFAppState().showAnimation = false);
    });

    tFTotalController = TextEditingController(text: '10.00');
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
          child: Stack(
            children: [
              SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                              child: TextFormField(
                                onChanged: (_) => EasyDebounce.debounce(
                                  'tFTotalController',
                                  Duration(milliseconds: 2000),
                                  () => setState(() {}),
                                ),
                                controller: tFTotalController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Total',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Enter total price',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          12, 8, 8, 8),
                                  suffixIcon: tFTotalController.text.isNotEmpty
                                      ? InkWell(
                                          onTap: () => setState(
                                            () => tFTotalController.clear(),
                                          ),
                                          child: Icon(
                                            Icons.clear,
                                            color: Color(0xFF757575),
                                            size: 22,
                                          ),
                                        )
                                      : null,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              oPayload = await actions.createPayload();
                              oCallPayment = await CallPaymentCall.call(
                                login: getJsonField(
                                  oPayload,
                                  r'''$.auth.login''',
                                ).toString(),
                                tranKey: getJsonField(
                                  oPayload,
                                  r'''$.auth.tranKey''',
                                ).toString(),
                                nonce: getJsonField(
                                  oPayload,
                                  r'''$.auth.nonce''',
                                ).toString(),
                                seed: getJsonField(
                                  oPayload,
                                  r'''$.auth.seed''',
                                ).toString(),
                                total: double.parse(tFTotalController.text),
                                expiration: getJsonField(
                                  oPayload,
                                  r'''$.expiration''',
                                ).toString(),
                              );
                              setState(() => FFAppState().payUrl = getJsonField(
                                    (oCallPayment?.jsonBody ?? ''),
                                    r'''$.processUrl''',
                                  ).toString());

                              setState(() {});
                            },
                            child: Container(
                              width: 48,
                              height: 50,
                              decoration: BoxDecoration(),
                              child: Icon(
                                Icons.refresh_rounded,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.78,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                      ),
                      child: FlutterFlowWebView(
                        url: FFAppState().payUrl,
                        bypass: true,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1,
                        verticalScroll: true,
                        horizontalScroll: false,
                      ),
                    ),
                  ],
                ),
              ),
              if (FFAppState().showAnimation ?? true)
                Align(
                  alignment: AlignmentDirectional(0, -0.73),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Lottie.network(
                      'https://assets7.lottiefiles.com/packages/lf20_taDv2I.json',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      animate: true,
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
