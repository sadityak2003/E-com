import 'package:ecom/screens/productDetails.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../services/api_service.dart';

class ShopScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: apiService.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products found.'));
        }
        else {
          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: product),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          product.image != null
                              ? Image.network(
                            product.image!,
                            width: 200,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                              : const Icon(Icons.image),
                          if (product.discountPercentage > 0)
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                color: Colors.red,
                                child: Text(
                                  '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _buildRatingStars(product.rating),
                                const SizedBox(width: 5),
                                Text(
                                  '(${product.itemsPurchased})',
                                ),
                              ],
                            ),
                            Text(
                              product.title,
                              style: const TextStyle(fontWeight: FontWeight.w400),
                            ),
                            Text(
                              product.category.toUpperCase(),
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${product.oldPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 10), // Optional spacing between prices
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildRatingStars(double rating) {
    final int fullStars = rating.floor();
    final double remainder = rating - fullStars;
    final int halfStar = (remainder >= 0.5) ? 1 : 0;

    return Row(
      children: List.generate(
        5,
            (index) {
          if (index < fullStars) {
            return const Icon(Icons.star, color: Colors.yellow);
          } else if (index == fullStars && halfStar == 1) {
            return const Icon(Icons.star_half, color: Colors.yellow);
          } else {
            return const Icon(Icons.star_border, color: Colors.yellow);
          }
        },
      ),
    );
  }
}
