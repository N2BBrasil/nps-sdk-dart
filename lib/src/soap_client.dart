import 'package:http/http.dart';
import 'package:nps_sdk/nps_sdk.dart';

Future<Map> sendRequest({
  required String method,
  required NpsEnvironment environment,
  params,
}) async {
  var httpRequest = toXml(params, method);
  Response httpResponse = await post(
    environment.uri,
    headers: {
      "SOAPAction": method,
      "Content-Type": "text/xml; charset=utf-8",
      "Host": environment.host,
    },
    body: httpRequest.toXmlString(),
  );

  stringPrettyPrint(httpResponse.body);
  return toMap(httpResponse, method + "Response");
}
