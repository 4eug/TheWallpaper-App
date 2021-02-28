class PicturesModel {
  String url;
  String photographer;
  String photographerUrl;
  int photographerId;
  SrcModel src;

  PicturesModel(
      {this.url,
      this.photographer,
      this.photographerId,
      this.photographerUrl,
      this.src});

  factory PicturesModel.fromMap(Map<String, dynamic> parsedJson) {
    return PicturesModel(
        url: parsedJson["url"],
        photographer: parsedJson["photographer"],
        photographerId: parsedJson["photographer_id"],
        photographerUrl: parsedJson["photographer_url"],
        src: SrcModel.fromMap(parsedJson["src"]));
  }
}

class SrcModel {
  String portrait;
  String large;
  String landscape;
  String medium;

  SrcModel({this.portrait, this.landscape, this.large, this.medium});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        large: srcJson["large"],
        landscape: srcJson["landscape"],
        medium: srcJson["medium"]);
  }
}
