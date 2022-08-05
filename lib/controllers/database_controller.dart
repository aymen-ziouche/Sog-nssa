

import 'package:sognssa/models/product.dart';
import 'package:sognssa/services/firestore_services.dart';

abstract class Database {
  Stream<List<Product>> productsStream();
}

class FirestoreDatabase implements Database {
  final _service = FirestoreServices.instance;

  @override
  Stream<List<Product>> productsStream() => _service.collectionsStream(
        path: 'products/',
        builder: (data, documentId) => Product.fromMap(data!, documentId),
      );
}