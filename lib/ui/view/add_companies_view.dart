import 'package:flutter/material.dart';
import 'package:todoapp/core/api_service.dart';
import 'package:todoapp/core/model/companies/companies.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  GlobalKey<FormState> formKey = GlobalKey(debugLabel: "formKey");

  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: productNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Product Name",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  validator: _validator,
                ),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Price ",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Price is required";
                    } else if (int.tryParse(value) == null) {
                      return "Price must be a number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: "Url",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  validator: _validator,
                ),
                ElevatedButton.icon(
                  label: const Text("Save"),
                  onPressed: () async {
                    var model = Companies(
                      productName: productNameController.text,
                      money: int.parse(priceController.text),
                      imageUrl: imageController.text,
                    );

                    await _addCompanies(model).then((value) => Navigator.pop(context, value));
                  },
                  icon: const Icon(Icons.save),
                  style: ButtonStyle(shape: MaterialStateProperty.all<StadiumBorder>(const StadiumBorder())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _addCompanies(Companies model) async {
    await ApiService.getInstance().addCompanies(model);
    return true;
  }

  String? _validator(value) {
    if (value!.isEmpty) {
      return "Product Name is required";
    }
    return null;
  }
}
