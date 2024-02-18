import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:norq_technologies/screens/categories/all_products.dart';
import 'package:norq_technologies/screens/categories/electronic_screen.dart';
import 'package:norq_technologies/screens/categories/jewelery_screen.dart';
import 'package:norq_technologies/screens/categories/men_screen.dart';
import 'package:norq_technologies/screens/categories/women_screen.dart';
import 'package:norq_technologies/screens/details_screen/cart_screen.dart';
import 'package:norq_technologies/service/api_client.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade200,
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.shade300,
              ),
              child: const Icon(
                Icons.person,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Hi, Arif",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          const Icon(
            Icons.search,
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              ApiClient().getProducts();
              Get.to(() => const CartScreen());
            },
            child: const Icon(Icons.add_shopping_cart),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.grey,
                dividerColor: Colors.white,
                labelPadding: const EdgeInsets.symmetric(horizontal: 3),
                indicator: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                tabs: const [
                  Tab(
                    text: "All",
                  ),
                  Tab(
                    text: "Men's",
                  ),
                  Tab(
                    text: "Women's",
                  ),
                  Tab(
                    text: "Jeweler's",
                  ),
                  Tab(
                    text: "Electronics",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    AllProducts(),
                    MenProducts(),
                    WomenProducts(),
                    JeweleryProducts(),
                    ElectronicProducts(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
