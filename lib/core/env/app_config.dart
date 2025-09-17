class AppConfig {
  final String baseUrl;
  final String flavor;

  const AppConfig({required this.baseUrl, required this.flavor});
  static AppConfig fromEnv(){
    const base = String.fromEnvironment('BASE_URL', defaultValue: "");
    const flv = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    return AppConfig(baseUrl: base, flavor: flv);
  }

  bool get isProd => flavor.toLowerCase() == 'prod';
}