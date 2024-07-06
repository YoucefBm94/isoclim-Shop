import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';

import '../../../services/firestoreservice.dart';
import '../../../size_config.dart';
import 'section_title.dart';

/// A widget that displays a list of popular products.
///
/// This widget fetches the list of products from Firestore and displays
/// only the products that are marked as popular. The products are displayed
/// in a horizontal scrollable list.
class PopularProducts extends StatefulWidget {

  /// Creates a PopularProducts widget.
  const PopularProducts({super.key});

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  /// The Firestore service to use for fetching products.
  FirestoreService ref =FirestoreService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: ref.getProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        // Show a loading spinner while waiting for the products to load.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        // Show an error message if something went wrong while loading the products.
        else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        // If the products have loaded successfully, display them in a list.
        else {
          List<Product> products = snapshot.data!;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: SectionTitle(title: "Popular Products", press: () {}),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      products.length,
                          (index) {
                        // Only display the product if it is marked as popular.
                        if (products[index].isPopular) {
                          return ProductCard(product: products[index]);
                        }

                        // If the product is not popular, don't display anything.
                        return const SizedBox.shrink();
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                ),
              )
            ],
          );
        }
      },
    );
  }
}