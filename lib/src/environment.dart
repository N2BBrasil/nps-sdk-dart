enum NpsEnvironment {
  sandbox,
  staging,
  production,
}

extension NpsEnvironmentExtension on NpsEnvironment {
  String get host {
    switch (this) {
      case NpsEnvironment.sandbox:
        return 'sandbox.nps.com.ar';
      case NpsEnvironment.production:
        return 'services4.nps.com.ar';
      case NpsEnvironment.staging:
      default:
        return 'implementacion.nps.com.ar';
    }
  }
}
