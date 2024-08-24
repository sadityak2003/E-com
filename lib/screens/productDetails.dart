import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      product.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.grey,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.brand,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            _buildRatingStars(product.rating),
                            Text(
                              '(${product.itemsPurchased})',
                            ),
                          ],
                        )
                      ],
                    ),
                    // Right side: Price

                  ],
                ),

              const SizedBox(height: 10),
              // Additional product details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const SizedBox(height: 10),
                    Text('Description: ${product.description}'),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 150),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white
                  ),
                    onPressed: (){},
                    child: const Text("ADD TO CART"),
                ),
              )
            ],
          ),
        ),
      ),
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
