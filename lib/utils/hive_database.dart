import 'package:hive/hive.dart';

class HiveDataBase {
  final Box storedBox = Hive.box('hiveStorage');
  final _productsKey = 'productsBox';
  List<dynamic> allCalls = [];

  Future<void> setProducts(Map<String, dynamic> values) async {
    /*  List<dynamic> products = getProducts();
    products.add(products);
    await storedBox.put(_productsKey, products);*/
    allCalls.add(values);
    await storedBox.put(_productsKey, allCalls);
  }

  List<dynamic>? getProducts() {
    return storedBox.get(_productsKey);
  }

  void deleteProducts() {
    storedBox.delete(_productsKey);
  }
}
