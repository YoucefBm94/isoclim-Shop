import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';

import '../../../services/firestoreservice.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final Product product;

  Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
              ),
              TextButton.icon(
                onPressed: () async {
                  try {
                    await _firestoreService
                        .downloadFileFromFirebase(widget.product.pdfUrl);
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
