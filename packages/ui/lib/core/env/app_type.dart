enum AppType {
  eesup,
  mykasi;

  factory AppType.fromString(String appType) {
    switch (appType) {
      case 'eesup':
        return AppType.eesup;
      case 'mykasi':
        return AppType.mykasi;
      default:
        return AppType.eesup;
    }
  }
}
