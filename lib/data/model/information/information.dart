class InformationModel {
  int? success;
  List<InformationDataModel>? data;

  InformationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <InformationDataModel>[];
      json['data'].forEach((v) {
        data!.add(InformationDataModel.fromJson(v));
      });
    }
  }
}


class OneInformationModel{
  int? success ;
  InformationDataModel? informationDataModel;

  OneInformationModel.fromJson(Map<String,dynamic> json){
    success = json["success"];
    informationDataModel = json["data"] != null ? InformationDataModel.fromJson(json["data"]) :null;
  }

}

class InformationDataModel {
  int? id;
  String? title;
  String? description;
  String? status;

  InformationDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description_pure'];
    status = json['status'];
  }
}
