import 'package:the_wallpapers/model/varieties_model.dart';

String apiKEY = "563492ad6f91700001000001bcf635e158bb4fe9adbf7100cfb75cae";

List<VarietiesModel> getVarieties() {
  // ignore: deprecated_member_use
  List<VarietiesModel> varieties = new List();
  VarietiesModel varietieModel = new VarietiesModel();

  //
  // varietieModel.imgUrl =
  //     "https://images.pexels.com/photos/2156881/pexels-photo-2156881.jpeg?cs=srgb&dl=pexels-anni-roenkae-2156881.jpg&fm=jpg";
  varietieModel.varietieName = "Abstract";
  varieties.add(varietieModel);
  varietieModel = new VarietiesModel();

  //
  // varietieModel.imgUrl =
  //     "https://images.pexels.com/photos/3568520/pexels-photo-3568520.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  varietieModel.varietieName = "Technology";
  varieties.add(varietieModel);
  varietieModel = new VarietiesModel();

  //
  // varietieModel.imgUrl =
  //     "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  varietieModel.varietieName = "Nature";
  varieties.add(varietieModel);
  varietieModel = new VarietiesModel();

  //
  // varietieModel.imgUrl =
  //     "https://images.pexels.com/photos/337909/pexels-photo-337909.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260";
  varietieModel.varietieName = "Cars";
  varieties.add(varietieModel);
  varietieModel = new VarietiesModel();

//
  // varietieModel.imgUrl =
  //     "https://images.pexels.com/photos/3304057/pexels-photo-3304057.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  varietieModel.varietieName = "Food";
  varieties.add(varietieModel);
  varietieModel = new VarietiesModel();

  //
  // varietieModel.imgUrl =
  //     "https://images.pexels.com/photos/4315839/pexels-photo-4315839.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  varietieModel.varietieName = "Music";
  varieties.add(varietieModel);
  varietieModel = new VarietiesModel();

  //
  // varietieModel.imgUrl =
  //     "https://images.pexels.com/photos/1662159/pexels-photo-1662159.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  varietieModel.varietieName = "Architecture";
  varieties.add(varietieModel);
  varietieModel = new VarietiesModel();

  return varieties;
}
