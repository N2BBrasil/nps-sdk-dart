library nps_sdk;

import 'package:nps_sdk/src/environment.dart';
import 'package:nps_sdk/src/soap_client.dart';

export 'src/deserializer.dart';
export 'src/environment.dart';
export 'src/serializer.dart';
export 'src/soap_client.dart';
export 'src/utilities.dart';

class NPSIngenico {
  NPSIngenico({this.environment = NpsEnvironment.staging});

  final NpsEnvironment environment;

  bool _debug = false;
  bool get logging => _debug;

  set logging(bool state) => _debug = state;

  Future createPaymentMethodToken(Map<String, dynamic> params) async {
    final response = await sendRequest(
      method: 'CreatePaymentMethodToken',
      environment: environment,
      params: params,
    );

    return response;
  }
}
