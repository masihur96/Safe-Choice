
import 'package:safe_choice/model/product_model.dart';

import 'data_provider.dart';

class ProductRepository {
  final DataProvider _dataProvider = DataProvider();
  Future< List<ProductModel>> getProducts() async {
    try {
      final header = {"apikey": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im53ZG5jamhkZ2trc3ZvbGxwZ3N3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQyMTUzMTMsImV4cCI6MjA1OTc5MTMxM30.7CGPTFjI7WwxoN2Xmr-imIhobpqs9yaJX1JGwi9uGfI"};

      final response = await _dataProvider.fetchData(
          "GET", "https://nwdncjhdgkksvollpgsw.supabase.co/rest/v1/products?order=product_serial.asc",
          header: header);

      if (response != null && response.statusCode == 200) {

        final data = response.data; // This should be List<dynamic>

        if (data is List) {
          List<ProductModel> products = data
              .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
              .toList();

           return products;
        } else {
          print("Unexpected data format: ${data.runtimeType}");
          return [];
        }

      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching notifications: $e");
      return [];
    }
  }
}
