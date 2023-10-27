import 'package:cova_admin_dashboard/constants/constants.dart';

class SupportModel {
  final String? name;
  final String? email;
  final String? subject;
  final String? message;
  final DateTime? date;
  SupportModel({this.message, this.date, this.name, this.email, this.subject, });

  fromSnap(Map<String, dynamic> map) {
    return SupportModel(
      name: map[AppConstants.fields][AppConstants.name][AppConstants.stringValue],
      email: map[AppConstants.fields][AppConstants.email][AppConstants.stringValue],
      subject: map[AppConstants.fields][AppConstants.subject][AppConstants.stringValue],
      message: map[AppConstants.fields][AppConstants.message][AppConstants.stringValue],
        date: DateTime.fromMillisecondsSinceEpoch(int.parse(map[AppConstants.fields][AppConstants.timestamp][AppConstants.integerValue]))
    );
  }

  List<SupportModel> getSupports(List lists) {
    List<SupportModel> supports = [];
    // print(lists[0][AppConstants.fields]);
    for (var map in lists) {
      supports.add(SupportModel().fromSnap(map));
    }
    return supports;
  }

}