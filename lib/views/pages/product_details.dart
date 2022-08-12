import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sognssa/controllers/database_controller.dart';
import 'package:sognssa/models/add_to_cart_module.dart';
import 'package:sognssa/models/product.dart';
import 'package:sognssa/utils/constants.dart';
import 'package:sognssa/views/widgets/drop_down_menu.dart';
import 'package:sognssa/views/widgets/main_button.dart';
import 'package:sognssa/views/widgets/main_dialog.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
  late String dropdownValue;

    Future<void> _addToCart(Database database) async {
    try {
      final addToCartProduct = AddToCartModel(
        id: documentIdFromLocalData(),
        title: widget.product.title,
        price: widget.product.price,
        productId: widget.product.id,
        imgUrl: widget.product.imgUrl,
        size: dropdownValue,
      );
      await database.addToCart(addToCartProduct);
    } catch (e) {
      return MainDialog(
        context: context,
        title: 'Error',
        content: 'Couldn\'t add to the cart, please try again!',
      ).showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.product.title,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Colors.white,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.imgUrl,
              width: double.infinity,
              height: size.height * 0.55,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: InkWell(
                  //     onTap: () {
                  //       setState(() {
                  //         isFavorite = !isFavorite;
                  //       });
                  //     },
                  //     child: SizedBox(
                  //       height: 50,
                  //       width: 50,
                  //       child: DecoratedBox(
                  //         decoration: const BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: Colors.white,
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Icon(
                  //             isFavorite
                  //                 ? Icons.favorite
                  //                 : Icons.favorite_border_outlined,
                  //             color: Theme.of(context).primaryColor,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: DropDownMenuComponent(
                            items: const ['S', 'M', 'L', 'XL', 'XXL'],
                            hint: 'Size',
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                      Text(
                        '\$${widget.product.price}',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.product.category,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'This is a dummy description for this product! I think we will add it in the future! I need to add more lines, so I add these words just to have more than two lines!',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 24.0),
                  MainButton(
                    text: 'Add to cart',
                    onTap: () => _addToCart(database),
                    hasCircularBorder: true,
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
