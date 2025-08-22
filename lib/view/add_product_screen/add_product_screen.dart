import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:luminar_api_sample_april_2025/controller/add_screen_controller.dart';
import 'package:luminar_api_sample_april_2025/controller/home_contrller.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await context
          .read<AddScreenController>()
          .addProduct(
            name: _nameController.text,
            desc: _descController.text,
            price: _priceController.text,
            stock: _stockController.text,
            category: _categoryController.text,
          )
          .then((value) {
            if (value == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("✅ Product Added Successfully"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
              context.read<HomeController>().fetchMyProducts();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Failed to add porduct"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          });
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.blueAccent),
      labelText: label,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Add Product",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration(
                        "Product Name",
                        Icons.shopping_bag,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter product name";
                        }
                        if (value.trim().length < 3) {
                          return "Minimum 3 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _descController,
                      maxLines: 3,
                      decoration: _inputDecoration(
                        "Description",
                        Icons.description,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter description";
                        }
                        if (value.trim().length < 10) {
                          return "Minimum 10 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration("Price", Icons.attach_money),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Enter price";
                        final num? price = num.tryParse(value);
                        if (price == null || price <= 0)
                          return "Enter valid price > 0";
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _stockController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration("Stock", Icons.inventory),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Enter stock";
                        final int? stock = int.tryParse(value);
                        if (stock == null || stock < 0)
                          return "Enter valid stock >= 0";
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _categoryController,
                      decoration: _inputDecoration("Category", Icons.category),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter category";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: _submitForm,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.blueAccent, Colors.lightBlue],
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Add Product",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
