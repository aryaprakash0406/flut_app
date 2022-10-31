
import 'package:api_render/models/overview.dart';
import 'package:http/http.dart' as http;

import '../models/performance.dart';

class RemoteData {
  Future<OverviewModel?> fetchOverViewData() async {
    var url=Uri.parse("https://api.stockedge.com/Api/SecurityDashboardApi/GetCompanyEquityInfoForSecurity/5051?l ang=en");
    var response=await http.get(url);
    if (response.statusCode==200) {
      var json = response.body;
      return overviewModelFromJson(json);
    }
    return null;
  }

  Future<List<PerformanceModel>?> fetchPerformancedata() async {
    var url=Uri.parse("https://api.stockedge.com/Api/SecurityDashboardApi/GetTechnicalPerformanceBenchmarkForS ecurity/5051?lang=en");
    var response=await http.get(url);
    if(response.statusCode==200){
      var json=response.body;
      return performanceModelFromJson(json);
    }
    return null;
  }

}