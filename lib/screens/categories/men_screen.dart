import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:norq_technologies/controllers/product_controller.dart';
import 'package:norq_technologies/screens/details_screen/product_details_screen.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class MenProducts extends StatelessWidget {
  const MenProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 100;
    var height = MediaQuery.of(context).size.height / 100;
    ProductController productController = Get.find();
    return GridView.builder(
      itemCount: productController.menList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisExtent: height * 30,
          crossAxisSpacing: width * 4.5,
          mainAxisSpacing: width * 5),
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> productDetails = productController.menList[index];
        return InkWell(
          onTap: () {
            Get.to(
              () => ProductDetailsScreen(
                productDetails: productDetails,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                width: 165,
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
                    fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87, overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
              //  const SizedBox(height: 10),
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
            ],
          ),
        );
      },
    );
  }
}
