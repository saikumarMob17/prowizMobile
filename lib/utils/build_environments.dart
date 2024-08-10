enum BuildFlavour { development, uat, production }

BuildEnvironments? _env;

BuildEnvironments? get env => _env;

class BuildEnvironments {
  final BuildFlavour? flavour;

  BuildEnvironments._init({this.flavour});

  static void init({required flavour}) =>
      _env ??= BuildEnvironments._init(flavour: flavour);

  static BuildFlavour? getBuildFlavour() => _env?.flavour;

  static String getBaseUrl() => _env?.flavour == BuildFlavour.development
      ? DevEnvironment.baseURL
      : _env?.flavour == BuildFlavour.uat
          ? UatEnvironment.baseURL
          : ProductionEnvironment.baseURL;
}

class DevEnvironment {
  static String baseURL = "https://api.prowizlive.com/api/";

}

class UatEnvironment {
  static String baseURL = "https://api.prowizlive.com/api/";
}

class ProductionEnvironment {
  static String baseURL = "https://api.prowizlive.com/api/";
}
