
import 'package:sognssa/controllers/database_controller.dart';
import 'package:sognssa/models/shipping_address.dart';

class AddShippingAddressArgs {
  final Database database;
  final ShippingAddress? shippingAddress;

  AddShippingAddressArgs({required this.database, this.shippingAddress});
}