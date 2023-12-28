import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../models/Product.dart';

/// A service class to interact with Firestore database.
class FirestoreService {
  /// An instance of FirebaseFirestore to interact with the Firestore database.
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Fetches all products from the 'products' collection in Firestore.
  ///
  /// This method retrieves all documents from the 'products' collection,
  /// converts each document to a `Product` object, and returns a list of these objects.
  ///
  /// Returns:
  /// A `Future` that completes with a list of `Product` objects.
  Future<List<Product>> getProducts() async {
    // Reference to the 'products' collection in Firestore.
    var ref = _db.collection('products');

    // Snapshot of the 'products' collection.
    var snapshot = await ref.get();

    // Extract data from each document in the snapshot.
    var data = snapshot.docs.map((s) => s.data());

    // Map the data to `Product` objects.
    var products = data.map((m) => Product.fromJson(m)).toList();

    // Return the list of `Product` objects.

    return products.toList();
  }

  /// Fetches a single product from the 'products' collection in Firestore.
  ///
  Future<Product> getProduct(String id) async {
    // Reference to the 'products' collection in Firestore.
    var ref = _db.collection('products');

    // Snapshot of the 'products' collection.
    var snapshot = await ref.doc(id).get();

    // Extract data from the document snapshot.
    var data = snapshot.data();

    // Map the data to a `Product` object.
    var product = Product.fromJson(data!);

    // Return the `Product` object.
    return product;
  }



  Future<List<Product>> getProductsByCategory(String categoryName) async {
    // Reference to the 'products' collection in Firestore.
    var ref = _db.collection('products');

    // Query the 'products' collection for documents where 'category' is equal to categoryName.
    var snapshot = await ref.where('category.name', isEqualTo: categoryName).get();

    // Extract data from each document in the snapshot.
    var data = snapshot.docs.map((s) => s.data());

    // Map the data to `Product` objects.
    var products = data.map((m) => Product.fromJson(m)).toList();

    // Return the list of `Product` objects.
    return products.toList();
  }



  Future<String> uploadFile(String folder, File file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = _storage.ref().child('$folder/$fileName');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<String> uploadImage(File file) async {
    return uploadFile('product_images', file);
  }

  Future<String> uploadPdf(File file) async {
    return uploadFile('product_pdfs', file);
  }




  Future<String?> downloadFileFromFirebase(String fileUrl) async {


    // Get the local path to save the file
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String localPath = appDocDir.path;

    // Ensure the directory exists
    Directory(localPath).createSync(recursive: true);

    // Parse the file URL to get the file name
    String fileName = Uri.parse(fileUrl).pathSegments.last;

    // Add a timestamp to the filename to ensure uniqueness
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String uniqueFileName = '$timestamp-$fileName';

    // Enqueue the download task
    final taskId = await FlutterDownloader.enqueue(
      url: fileUrl,
      savedDir: localPath,
      fileName: '$uniqueFileName.pdf',
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );

    return taskId;
  }






  Future<void> addProduct(Product product) async {
    product.images = await Future.wait(product.images.map((image) async {
      return await uploadImage(File(image));
    }));

    product.pdfUrl = await uploadPdf(File(product.pdfUrl));


    // Create a new document reference
    DocumentReference docRef = _db.collection('products').doc();

// Convert the Category instance to a Map
    Map<String, dynamic> categoryJson = product.category!.toJson();

    // Create a new Map with the product data and the converted Category
    Map<String, dynamic> productJson = product.toJson();
    productJson['category'] = categoryJson;

    // Add the product data to the Firestore document
    await docRef.set(productJson);
  }


}