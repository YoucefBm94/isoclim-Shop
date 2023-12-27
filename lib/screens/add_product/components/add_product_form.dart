import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/components/default_button.dart';

import '../../../models/Category.dart';
import '../../../models/Product.dart';
import '../../../services/FirestoreService.dart';
import '../../../size_config.dart';


class AddProductsForm extends StatefulWidget {
  const AddProductsForm({super.key});

  @override
  AddProductsFormState createState() => AddProductsFormState();
}

class AddProductsFormState extends State<AddProductsForm> {
  final _formKey = GlobalKey<FormState>();
  String? title, description;
  List<String>? images;
  double? rating, price;
  bool? isFavourite, isPopular;
  String? pdfUrl;
  EnumCategories? selectedCategory;

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  FirestoreService firestoreService = FirestoreService();




  double uploadProgress = 0;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: getProportionateScreenHeight(30)),
          buildTitleFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildDescriptionFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPriceFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildRatingFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildIsFavouriteSwitch(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildIsPopularSwitch(),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildImagesPicker(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPdfPicker(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildCategoriesDropdown(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "continue",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                Product product = Product(
                  id:"",
                  images: images,
                  rating: rating!,
                  isFavourite: isFavourite!,
                  isPopular: isPopular!,
                  title: title!,
                  price: price!,
                  description: description!,
                  pdfUrl: pdfUrl!,
                  category: Category(name: selectedCategory.toString().split('.').last)
                );

                await firestoreService.addProduct(product);

                context.go('/HomeScreen');
              }
            },
          ),
        ],
      ),
    );
  }

  DropdownButton<EnumCategories> buildCategoriesDropdown() {
    return DropdownButton<EnumCategories>(
      value: selectedCategory,
      hint: Text('Select Category'),
      onChanged: (EnumCategories? newValue) {
        setState(() {
          selectedCategory = newValue;
        });
      },
      items: EnumCategories.values.map<DropdownMenuItem<EnumCategories>>((EnumCategories value) {
        return DropdownMenuItem<EnumCategories>(
          value: value,
          child: Text(value.toString().split('.').last),
        );
      }).toList(),
    );
  }

  Widget buildPdfPicker() {
    return ElevatedButton(
      child: const Text('Pick PDF'),
      onPressed: () async {
        final FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

        if (result != null) {
          pdfUrl = result.files.single.path;
        }
      },
    );
  }

  TextFormField buildTitleFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Title",
        hintText: "Enter product title",
      ),
      onSaved: (newValue) => title = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter product title';
        }
        return null;
      },
    );
  }

  TextFormField buildDescriptionFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Description",
        hintText: "Enter product description",
      ),
      onSaved: (newValue) => description = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter product description';
        }
        return null;
      },
    );
  }

  TextFormField buildPriceFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Price",
        hintText: "Enter product price",
      ),
      onSaved: (newValue) => price = double.parse(newValue!),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter product price';
        }
        return null;
      },
    );
  }

  TextFormField buildRatingFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Rating",
        hintText: "Enter product rating",
      ),
      onSaved: (newValue) => rating = double.parse(newValue!),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter product rating';
        }
        return null;
      },
    );
  }

  Widget buildImagesPicker() {
    return ElevatedButton(
      child: const Text('Pick Images'),
      onPressed: () async {
        final FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.image,
        );

        if (result != null) {
          List<String> imagePaths = [];
          for (PlatformFile file in result.files) {
            imagePaths.add(file.path!);
          }

          setState(() {
            images = imagePaths;
          });
        }
      },
    );
  }

  SwitchListTile buildIsFavouriteSwitch() {
    return SwitchListTile(
      title: const Text('Is Favourite'),
      value: isFavourite ?? false,
      onChanged: (value) {
        setState(() {
          isFavourite = value;
        });
      },
    );
  }

  SwitchListTile buildIsPopularSwitch() {
    return SwitchListTile(
      title: const Text('Is Popular'),
      value: isPopular ?? false,
      onChanged: (value) {
        setState(() {
          isPopular = value;
        });
      },
    );
  }
}
