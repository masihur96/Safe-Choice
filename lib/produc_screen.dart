import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_choice/repository/product_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'model/product_model.dart';



class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductRepository _productRepository =
  ProductRepository();
  bool _isProductLoading = false;
  @override
  void initState() {
    super.initState();

    fetchProducts();
    // fetchNotification();
  }


  void fetchNotification() async {
    setState(() {

      _isProductLoading = true;
    });


      ProductModel?     productModel = await _productRepository.getProducts();

      if (productModel != null) {



      }

    setState(() {
      _isProductLoading = false;
    });
  }

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response = await Supabase.instance.client
        .from('products')
        .select()
        .order('name', ascending: true);

    if (response != null) {
      return List<Map<String, dynamic>>.from(response);
    } else {
      throw Exception("Failed to load products");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: GestureDetector(

        onTap: (){
          fetchProducts();
          // fetchNotification();
          },

          child: Text('Product List'))),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No products found"));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Image.network(product['image']),
                  title: Text(product['name']),
                  subtitle: Text(product['category']),
                  trailing: Text('${product['flag']} \$${product['price']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
