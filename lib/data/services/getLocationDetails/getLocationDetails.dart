import 'dart:convert';

import 'package:resort_store/data/network/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';


class GetLocationDetailsService {

  Future<dynamic> getLocationSV(double lat, double lon) async {
    final uri =

    Uri.parse( "https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon");

    http.Response response = await http.get(uri);

  final xml2json = Xml2Json();
  xml2json.parse(response.body);
  var jsonData = xml2json.toGData();
  var jsonDecode = json.decode(jsonData);
  print("----------------------------------------+++++++++++ ${jsonDecode["reversegeocode"]["addressparts"]}");


  print("##################################################################################");

     return jsonDecode["reversegeocode"]["addressparts"];

  }






}