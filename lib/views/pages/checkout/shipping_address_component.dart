import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sognssa/controllers/database_controller.dart';
import 'package:sognssa/models/shipping_address.dart';
import 'package:sognssa/utils/routes.dart';

class ShippingAddressComponent extends StatelessWidget {
  final ShippingAddress shippingAddress;
  const ShippingAddressComponent({Key? key, required this.shippingAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Card(
      color: Colors.white70,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shippingAddress.fullName,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.shippingAddressesRoute,
                    arguments: database,
                  ),
                  child: Text(
                    'Change',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              shippingAddress.address,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              '${shippingAddress.city}, ${shippingAddress.state}, ${shippingAddress.country}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
