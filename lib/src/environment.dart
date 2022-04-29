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
        return 'services2.nps.com.ar';
      case NpsEnvironment.staging:
      default:
        return 'implementacion.nps.com.ar';
    }
  }
}
