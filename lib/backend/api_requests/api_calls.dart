import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class CallPaymentCall {
  static Future<ApiCallResponse> call({
    String login = '',
    String tranKey = '',
    String nonce = '',
    String seed = '',
    double total,
    String expiration = '',
  }) {
    final body = '''
{
  "auth": {
    "login": "${login}",
    "tranKey": "${tranKey}",
    "nonce": "${nonce}",
    "seed": "${seed}"
  },
  "locale": "es_PR",
  "buyer": {
    "name": "Carlos",
    "surname": "Torres",
    "email": "ctorres@sarcopr.com",
    "document": "100016",
    "documentType": "CC",
    "mobile": 17873094976
  },
  "payment": {
    "reference": "60016",
    "description": "Pago completo",
    "amount": {
      "currency": "USD",
      "total": ${total}
    },
    "allowPartial": false
  },
  "expiration": "${expiration}",
  "returnUrl": "https://www.churchspr.com",
  "ipAddress": "127.0.0.1",
  "userAgent": "Sarco PR - Pruebas"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'callPayment',
      apiUrl: 'https://checkout-test.placetopay.com/api/session',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'login': login,
        'tranKey': tranKey,
        'nonce': nonce,
        'seed': seed,
        'total': total,
        'expiration': expiration,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic payUrl(dynamic response) => getJsonField(
        response,
        r'''$.processUrl''',
      );
}

class GetPtRequestInformationCall {
  static Future<ApiCallResponse> call({
    String login = '',
    String tranKey = '',
    String nonce = '',
    String seed = '',
    String requestId = '',
  }) {
    final body = '''
{
  "auth": {
    "login": "${login}",
    "tranKey": "${tranKey}",
    "nonce": "${nonce}",
    "seed": "${seed}"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getPtRequestInformation',
      apiUrl: 'https://checkout-test.placetopay.com/api/session/${requestId}',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'login': login,
        'tranKey': tranKey,
        'nonce': nonce,
        'seed': seed,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.status''',
      );
}
