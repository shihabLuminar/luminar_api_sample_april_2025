import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:luminar_api_sample_april_2025/controller/home_contrller.dart';
import 'package:luminar_api_sample_april_2025/utils/app_utils.dart';
import 'package:luminar_api_sample_april_2025/view/add_product_screen/add_product_screen.dart';
import 'package:luminar_api_sample_april_2025/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeController>().fetchMyProducts();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              // clear toke in shared preferences on  logout
              await AppUtils.asyncPrefs.clear();

              // navigate to login screen on logout
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String token = await AppUtils.getToken();
          log(token.toString());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<HomeController>().fetchMyProducts();
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: homeProvider.products.length,
          itemBuilder: (context, index) {
            final product = homeProvider.products[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: product.imageUrl != null
                          ? Image.network(
                              product.imageUrl,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 80,
                              width: 80,
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                    const SizedBox(width: 12),
                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.description.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "₹${product.price}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                "Stock: ${product.stock}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Category: ${product.category}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<HomeController>().productDele(
                                    product.id.toString(),
                                  );
                                },
                                icon: Icon(Icons.delete),
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
        ),
      ),
    );
  }
}
