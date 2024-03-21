import 'package:firebase_remote_config/firebase_remote_config.dart';

enum NpsEnvironment {
  sandbox,
  staging,
  production,
}

extension NpsEnvironmentExtension on NpsEnvironment {
  Uri get uri {
    switch (this) {
      case NpsEnvironment.sandbox:
        return Uri.parse('https://$host/ws.php');
      default:
        return Uri.parse('https://$host/');
    }
  }

  String get host {
    switch (this) {
      case NpsEnvironment.sandbox:
        return 'sandbox.nps.com.ar';
      case NpsEnvironment.production:
        final url = FirebaseRemoteConfig.instance.getString('ingenico_environment');
        if (url.isEmpty) throw Exception('ingenico_environment is empty');

        return url;
      case NpsEnvironment.staging:
      default:
        return 'implementacion.nps.com.ar';
    }
  }
}
