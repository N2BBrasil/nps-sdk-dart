import 'package:http/http.dart';
import 'package:nps_sdk/nps_sdk.dart';

sendRequest(Nps nps, params, method) async {
  var httpRequest = toXml(params, method);
  Response httpResponse = await post(Uri.parse(nps.environment),
      headers: {
        "SOAPAction": method,
        "Content-Type": "text/xml; charset=utf-8",
        "Host": nps.chooseHost()
      },
      body: httpRequest.toXmlString());
  stringPrettyPrint(httpResponse.body);

  return toMap(httpResponse, method + "Response");
}
