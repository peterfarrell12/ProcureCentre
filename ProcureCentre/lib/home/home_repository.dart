import 'dart:async';
import 'dart:html';



abstract class HomeRepository {

  Future<Map> getCompanyData(String company);

}
