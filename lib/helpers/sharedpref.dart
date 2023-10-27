
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class SaveDraft{

  static Future<bool> isNameSave(String name) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(AppConstants.name, name);
  }

  static Future<bool> isDraftSave(bool saveDraft) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(AppConstants.saveDraft, saveDraft);
  }

  static Future<bool> saveTitle(String title) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(AppConstants.title, title);
  }



  //Getting data from SharedPreference
  static Future<String?> getNameSave()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(AppConstants.name);
  }

  static Future<bool?> getIsDraftSave()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getBool(AppConstants.saveDraft);
  }

  static Future<String?> getTitle()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(AppConstants.title);
  }
}