import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sognssa/controllers/database_controller.dart';
import 'package:sognssa/models/shipping_address.dart';
import 'package:sognssa/utils/args_models/add_shipping_address_args.dart';
import 'package:sognssa/utils/routes.dart';

class ShippingAddressStateItem extends StatefulWidget {
  final ShippingAddress shippingAddress;
  const ShippingAddressStateItem({
    Key? key,
    required this.shippingAddress,
  }) : super(key: key);

  @override
  State<ShippingAddressStateItem> createState() =>
      _ShippingAddressStateItemState();
}

class _ShippingAddressStateItemState extends State<ShippingAddressStateItem> {
  late bool checkedValue;

  @override
  void initState() {
    super.initState();
    checkedValue = widget.shippingAddress.isDefault;
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Card(
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
                  widget.shippingAddress.fullName,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.addShippingAddressRoute,
                    arguments: AddShippingAddressArgs(
                      database: database,
                      shippingAddress: widget.shippingAddress,
                    ),
                  ),
                  child: Text(
                    'Edit',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.shippingAddress.address,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '${widget.shippingAddress.city}, ${widget.shippingAddress.state}, ${widget.shippingAddress.country}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            CheckboxListTile(
              title: const Text("Default shipping address"),
              value: checkedValue,
              onChanged: (newValue) async {
                setState(() {
                  checkedValue = newValue!;
                });
                // TODO: We need to add the business logic of adding the default address (one default)
                final newAddress =
                    widget.shippingAddress.copyWith(isDefault: newValue);
                await database.saveAddress(newAddress);
              },
              activeColor: Colors.black,
              contentPadding: EdgeInsets.zero,
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            )
          ],
        ),
      ),
    );
  }
}
