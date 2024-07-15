library nps_sdk;

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:nps_sdk/src/deserializer.dart';
import 'package:nps_sdk/src/environment.dart';
import 'package:nps_sdk/src/serializer.dart';
import 'package:http/http.dart';
import 'package:nps_sdk/src/utilities.dart';

export 'src/deserializer.dart';
export 'src/environment.dart';
export 'src/serializer.dart';
export 'src/soap_client.dart';
export 'src/utilities.dart';

class NPSIngenico {
  final NpsEnvironment? environment;
  final String? host;

  NPSIngenico({this.environment, this.host});

  NPSIngenicoInstance? _instance;

  Future<void> initializeInstance() async {
    _instance = await NPSIngenicoInstance.createInstance(
      environment: environment ?? NpsEnvironment.staging,
      host: host,
    );
  }

  Future createPaymentMethodToken(Map<String, dynamic> params) async {
    if (_instance == null) await initializeInstance();
    final response = await _instance!.sendRequest('CreatePaymentMethodToken', params: params);
    return response;
  }
}

class NPSIngenicoInstance {
  final NpsEnvironment environment;

  NPSIngenicoInstance._(this.environment, {String? host}) : _host = host;

  final String? _host;

  static Future<NPSIngenicoInstance> createInstance({
    NpsEnvironment environment = NpsEnvironment.staging,
    String? host,
  }) async {
    if (host == null && environment == NpsEnvironment.production) {
      final remoteConfig = FirebaseRemoteConfig.instance;

      if (remoteConfig.lastFetchStatus == RemoteConfigFetchStatus.noFetchYet) {
        await remoteConfig.fetchAndActivate();
      }

      final url = FirebaseRemoteConfig.instance.getString('ingenico_environment');
      if (url.isNotEmpty) host = url;
    }

    return NPSIngenicoInstance._(environment, host: host);
  }

  String get host => _host ?? environment.host;

  Uri get uri {
    switch (environment) {
      case NpsEnvironment.sandbox:
        return Uri.parse('https://$host/ws.php');
      default:
        return Uri.parse('https://$host/');
    }
  }

  Future<Map> sendRequest(String method, {params}) async {
    var httpRequest = toXml(params, method);
    Response httpResponse = await post(
      uri,
      headers: {
        "SOAPAction": method,
        "Content-Type": "text/xml; charset=utf-8",
        "Host": host,
      },
      body: httpRequest.toXmlString(),
    );

    stringPrettyPrint(httpResponse.body);
    return toMap(httpResponse, method + "Response");
  }
}
