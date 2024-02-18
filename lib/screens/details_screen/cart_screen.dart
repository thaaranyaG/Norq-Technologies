import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:norq_technologies/utils/hive_database.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> productList = HiveDataBase().getProducts();
    int minStock = 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade200,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          "Cart",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (BuildContext context, int index) {
            Map<dynamic, dynamic> productDetails = productList[index];
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 120,
                        height: 110,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 1.2,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Image.network(
                          productDetails['image'],
                        ),
                      ),
                      const SizedBox(width: 25),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productDetails['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                                maxLines: 4,
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
                                  const SizedBox(width: 5),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        minStock++;
                                        productDetails['price'] = productDetails['price'] * minStock;
                                      });
                                    },
                                    icon: const Icon(Icons.add, size: 20),
                                    splashColor: Colors.transparent,
                                  ),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFf8dddb),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        minStock.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (minStock > 1) {
                                            setState(() {
                                              minStock--;
                                              productDetails['price'] = productDetails['price'] * minStock;
                                            });
                                          }
                                        },
                                        icon: const Center(child: Icon(Icons.minimize, size: 20)),
                                        splashColor: Colors.transparent,
                                      ),
                                      const SizedBox(height: 7),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
