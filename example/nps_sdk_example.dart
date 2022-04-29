import 'package:nps_sdk/nps_sdk.dart';

main(List<String> arguments) async {
  NPSIngenico nps = new NPSIngenico();

  final createPaymentMethodTokenParams = <String, dynamic>{
    "psp_Version": "2.2",
    "psp_MerchantId": "",
    "psp_CardInputDetails": {
      "Number": "4507990000000010",
      "ExpirationDate": "2501",
      "SecurityCode": "123",
      "HolderName": "JOHN DOE"
    },
    "psp_ClientSession": ""
  };

  await nps.createPaymentMethodToken(
    createPaymentMethodTokenParams,
  );
}
