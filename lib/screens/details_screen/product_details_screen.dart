import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:norq_technologies/screens/details_screen/cart_screen.dart';
import 'package:norq_technologies/utils/hive_database.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.productDetails});
  final Map<String, dynamic> productDetails;

  @override
  Widget build(BuildContext context) {
    final HiveDataBase storeData = HiveDataBase();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade200,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: const Text(
          'Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              // Get.to(() => const CartScreen());
            },
            child: const Icon(Icons.add_shopping_cart),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image.network(
                productDetails['image'],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              productDetails['title'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            Row(
              children: [
                const Text(
                  '\u{20B9}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  productDetails['price'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                RatingStars(
                  editable: true,
                  rating: productDetails['rating']['rate'].toDouble(),
                  color: Colors.amber,
                  iconSize: 20,
                ),
                Text(
                  ' (${productDetails['rating']['count']})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Description :',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            Text(
              productDetails['description'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                storeData.setProducts(productDetails);
                Get.to(() => const CartScreen());
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
