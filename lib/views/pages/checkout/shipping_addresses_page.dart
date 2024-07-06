import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sognssa/controllers/database_controller.dart';
import 'package:sognssa/models/shipping_address.dart';
import 'package:sognssa/utils/args_models/add_shipping_address_args.dart';
import 'package:sognssa/utils/routes.dart';
import 'package:sognssa/views/pages/checkout/shipping_address_state_item.dart';

class ShippingAddressesPage extends StatefulWidget {
  const ShippingAddressesPage({super.key});

  @override
  State<ShippingAddressesPage> createState() => _ShippingAddressesPageState();
}

class _ShippingAddressesPageState extends State<ShippingAddressesPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF131416),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131416),
        title: Text(
          'Shipping Addresses',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: StreamBuilder<List<ShippingAddress>>(
              stream: database.getShippingAddresses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final shippingAddresses = snapshot.data;
                  return Column(
                    children: shippingAddresses!
                        .map(
                          (shippingAddress) => ShippingAddressStateItem(
                              shippingAddress: shippingAddress),
                        )
                        .toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AppRoutes.addShippingAddressRoute,
          arguments: AddShippingAddressArgs(database: database),
        ),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
