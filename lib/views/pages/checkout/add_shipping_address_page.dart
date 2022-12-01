import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sognssa/controllers/database_controller.dart';
import 'package:sognssa/models/shipping_address.dart';
import 'package:sognssa/utils/constants.dart';
import 'package:sognssa/views/widgets/main_button.dart';
import 'package:sognssa/views/widgets/main_dialog.dart';

class AddShippingAddressPage extends StatefulWidget {
  final ShippingAddress? shippingAddress;
  const AddShippingAddressPage({super.key, this.shippingAddress});

  @override
  State<AddShippingAddressPage> createState() => _AddShippingAddressPageState();
}

class _AddShippingAddressPageState extends State<AddShippingAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController();
  ShippingAddress? shippingAddress;

  @override
  void initState() {
    super.initState();
    shippingAddress = widget.shippingAddress;
    if (shippingAddress != null) {
      _fullNameController.text = shippingAddress!.fullName;
      _addressController.text = shippingAddress!.address;
      _cityController.text = shippingAddress!.city;
      _stateController.text = shippingAddress!.state;
      _zipCodeController.text = shippingAddress!.zipCode;
      _countryController.text = shippingAddress!.country;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> saveAddress(Database database) async {
    try {
      if (_formKey.currentState!.validate()) {
        final address = ShippingAddress(
          id: shippingAddress != null
              ? shippingAddress!.id
              : documentIdFromLocalData(),
          fullName: _fullNameController.text.trim(),
          country: _countryController.text.trim(),
          address: _addressController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
          zipCode: _zipCodeController.text.trim(),
        );
        await database.saveAddress(address);
        if (!mounted) return;
        Navigator.of(context).pop();
      }
    } catch (e) {
      MainDialog(
              context: context,
              title: 'Error Saving Address',
              content: e.toString())
          .showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF131416),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131416),
        title: Text(
          shippingAddress != null
              ? 'Editing Shipping Address'
              : 'Adding Shipping Address',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Colors.white,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your name',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your name',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your name',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _stateController,
                  decoration: const InputDecoration(
                    labelText: 'State/Province',
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your name',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _zipCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your name',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your name',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 32.0),
                MainButton(
                  text: 'Save Address',
                  onTap: () => saveAddress(database),
                  hasCircularBorder: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
