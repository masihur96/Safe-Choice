import 'dart:convert';

import 'package:safe_choice/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PREFSKey {

  //theme set and get
  Future<bool> setThemeIsDark(bool value) async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    bool status = await sf.setBool('isDarkTheme', value);
    return status;
  }

  Future<bool?> getThemeIsDark() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    bool? result = sf.getBool('isDarkTheme');
    return result;
  }

  Future<bool> removeThemeIsDark() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    bool status = await sf.remove('isDarkTheme');
    return status;
  }


  static Future<void> saveProductToSharedPreferences(List<ProductModel> productModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert the list of ProductModel to a list of maps
    List<Map<String, dynamic>> jsonList = productModel.map((item) => item.toJson()).toList();

    // Encode the list to JSON string
    String productJson = json.encode(jsonList);

    // Save the string to SharedPreferences
    await prefs.setString('productKey', productJson);
  }

  static Future<List<ProductModel>> getProductsFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? productJson = prefs.getString('productKey');

    if (productJson != null) {
      List<dynamic> productList = json.decode(productJson);
      return productList.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      return [];
    }
  }


}
