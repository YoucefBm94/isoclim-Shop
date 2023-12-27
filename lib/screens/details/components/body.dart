import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/size_config.dart';

import '../../../services/FirestoreService.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;
  FirestoreService _firestoreService = FirestoreService();

  Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TextButton.icon(
                onPressed: () async {
                  try {
                    await _firestoreService
                        .downloadFileFromFirebase(product.pdfUrl);
                  } catch (e) {
                    if (kDebugMode) {
                      print('Failed to download PDF: $e');
                    }
                  }
                },
                icon: const Icon(Icons.download), label: const Text('Download PDF'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
