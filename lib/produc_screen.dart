import 'package:flutter/material.dart';
import 'package:safe_choice/repository/product_repository.dart';
import 'model/product_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductRepository _productRepository = ProductRepository();

  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];

  bool _isLoading = false;

  String? selectedCategory;
  String? selectedSubcategory;

  List<String> get categories =>
      allProducts.map((e) => e.category).toSet().toList();

  List<String> get subcategories {
    if (selectedCategory == null) return [];
    return allProducts
        .where((e) => e.category == selectedCategory)
        .map((e) => e.subcategory)
        .toSet()
        .toList();
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    setState(() => _isLoading = true);
    allProducts = await _productRepository.getProducts();
    filteredProducts = List.from(allProducts);
    setState(() => _isLoading = false);
  }

  void applyFilters() {
    setState(() {
      filteredProducts = allProducts.where((product) {
        final categoryMatch =
            selectedCategory == null || product.category == selectedCategory;
        final subcategoryMatch = selectedSubcategory == null ||
            product.subcategory == selectedSubcategory;
        return categoryMatch && subcategoryMatch;
      }).toList();
    });
  }

  void resetFilters() {
    setState(() {
      selectedCategory = null;
      selectedSubcategory = null;
      filteredProducts = List.from(allProducts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Products'),
      //   actions: [
      //     IconButton(onPressed: fetchProducts, icon: const Icon(Icons.refresh))
      //   ],
      // ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            // Filters
            // Filter Section
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Filter Products",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Category Dropdown
                  Row(
                    children: [
                      const Icon(Icons.category, color: Colors.black54),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: "Category",
                            border: OutlineInputBorder(),
                          ),
                          value: selectedCategory,
                          items: categories
                              .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedCategory = val;
                              selectedSubcategory = null;
                            });
                            applyFilters();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Subcategory Dropdown
                  Row(
                    children: [
                      const Icon(Icons.subdirectory_arrow_right, color: Colors.black54),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: "Subcategory",
                            border: OutlineInputBorder(),
                          ),
                          value: selectedSubcategory,
                          items: subcategories
                              .map((subcat) => DropdownMenuItem(
                            value: subcat,
                            child: Text(subcat),
                          ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedSubcategory = val;
                            });
                            applyFilters();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Clear Filter Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: resetFilters,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Clear Filters"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                      ),
                    ),
                  )
                ],
              ),
            ),


            // Product Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductCard(product: product);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Product Image
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Product Details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(product.category,
                    style: const TextStyle(color: Colors.grey)),
                Text(product.subcategory,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product.flag} \$${product.price}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    Row(
                      children: List.generate(
                        5,
                            (i) => Icon(
                          i < product.rating
                              ? Icons.star
                              : Icons.star_border,
                          size: 16,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
