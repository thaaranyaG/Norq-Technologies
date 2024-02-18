import 'dart:developer';

import 'package:get/get.dart';
import 'package:norq_technologies/service/api_client.dart';

class ProductController extends GetxController {
  final RxBool isLoading = false.obs;
  RxList productsList = <dynamic>[].obs;
  RxList menList = <dynamic>[].obs;
  RxList jeweleryList = <dynamic>[].obs;
  RxList electronicsList = <dynamic>[].obs;
  RxList womenList = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllProduct();
  }

  Future<void> getAllProduct() async {
    isLoading.value = true;
    List<dynamic>? response = await ApiClient().getProducts();
    if (response!.isNotEmpty) {
      isLoading.value = false;
      productsList.value = response;
      categories();
    } else {
      isLoading.value = false;
      log("response null");
    }
  }

  void categories() {
    for (var product in productsList) {
      if (product['category'] == 'men\'s clothing') {
        menList.add(product);
      } else if (product['category'] == 'jewelery') {
        jeweleryList.add(product);
      } else if (product['category'] == 'electronics') {
        electronicsList.add(product);
      } else if (product['category'] == 'women\'s clothing') {
        womenList.add(product);
      }
    }
  }
}
