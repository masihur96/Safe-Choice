
import 'package:safe_choice/model/product_model.dart';

import 'data_provider.dart';

class ProductRepository {
  final DataProvider _dataProvider = DataProvider();
  Future<ProductModel?> getProducts() async {
    try {
      final header = {"apikey": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im53ZG5jamhkZ2trc3ZvbGxwZ3N3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQyMTUzMTMsImV4cCI6MjA1OTc5MTMxM30.7CGPTFjI7WwxoN2Xmr-imIhobpqs9yaJX1JGwi9uGfI"};

      final response = await _dataProvider.fetchData(
          "GET", "https://nwdncjhdgkksvollpgsw.supabase.co/rest/v1/products",
          header: header);

      if (response != null && response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching notifications: $e");
      return null;
    }
  }
}
