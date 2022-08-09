import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sognssa/controllers/database_controller.dart';
import 'package:sognssa/models/product.dart';
import 'package:sognssa/utils/assets.dart';
import 'package:sognssa/views/widgets/header_of_list.dart';
import 'package:sognssa/views/widgets/list_header.dart';
import 'package:sognssa/views/widgets/list_item_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return SingleChildScrollView(
      child: Container(
        color: const Color(0xFF131416),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  AppAssets.topBannerHomePageAsset,
                  width: double.infinity,
                  height: size.height * 0.3,
                  fit: BoxFit.cover,
                ),
                Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.3,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Text(
                    'Street Clothes',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  HeaderOfList(
                    onTap: () {},
                    title: 'Sale',
                    description: 'Super Summer Sale!!',
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 330,
                    child: StreamBuilder<List<Product>>(
                        stream: database.salesProductsStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            final products = snapshot.data;
                            if (products == null || products.isEmpty) {
                              return const Center(
                                child: Text('No Data Available!'),
                              );
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: products.length,
                              itemBuilder: (_, int index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListItemHome(
                                  product: products[index],
                                  isNew: true,
                                ),
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ),
                  const SizedBox(height: 12.0),
                  HeaderOfList(
                    onTap: () {},
                    title: 'New',
                    description: 'Super New Products!!',
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 330,
                    child: StreamBuilder<List<Product>>(
                        stream: database.newProductsStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            final products = snapshot.data;
                            if (products == null || products.isEmpty) {
                              return const Center(
                                child: Text('No Data Available!'),
                              );
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: products.length,
                              itemBuilder: (_, int index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListItemHome(
                                  product: products[index],
                                  isNew: true,
                                ),
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//   Widget _buildHeaderOfList(
//     BuildContext context, {
//     required String title,
//     VoidCallback? onTap,
//     required String description,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: Theme.of(context).textTheme.headline4!.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//             ),
//             InkWell(
//               onTap: onTap,
//               child: Text(
//                 'View All',
//                 style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                       color: Colors.white,
//                     ),
//               ),
//             ),
//           ],
//         ),
//         Text(
//           description,
//           style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                 color: Colors.white70,
//               ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final database = Provider.of<Database>(context);
//     return SingleChildScrollView(
//       child: Container(
//         color: const Color(0xFF131416),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               alignment: Alignment.bottomLeft,
//               children: [
//                 Image.network(
//                   AppAssets.topBannerHomePageAsset,
//                   width: double.infinity,
//                   height: size.height * 0.3,
//                   fit: BoxFit.cover,
//                 ),
//                 Opacity(
//                   opacity: 0.3,
//                   child: Container(
//                     width: double.infinity,
//                     height: size.height * 0.3,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 24.0, vertical: 16.0),
//                   child: Text(
//                     'Street Clothes',
//                     style: Theme.of(context).textTheme.headline4!.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24.0),
//             Padding(
//               padding:
//                   const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 50.0),
//               child: Column(
//                 children: [
//                   _buildHeaderOfList(
//                     context,
//                     title: 'Sale',
//                     description: 'Super Summer Sale!!',
//                   ),
//                   const SizedBox(height: 8.0),
//                   SizedBox(
//                   height: 300,
//                   child: StreamBuilder<List<Product>>(
//                       stream: database.salesProductsStream(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.active) {
//                           final products = snapshot.data;
//                           if (products == null || products.isEmpty) {
//                             return const Center(
//                               child: Text('No Data Available!'),
//                             );
//                           }
//                           return ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: products.length,
//                             itemBuilder: (_, int index) => Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: ListItemHome(product: products[index]),
//                                   ),
//                           );
//                         }
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }),
//                 ),
//                   _buildHeaderOfList(
//                     context,
//                     title: 'New',
//                     description: 'Super New Products!!',
//                   ),
//                   const SizedBox(height: 8.0),
//                   SizedBox(
//                     height: 300,
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: dummyProducts
//                           .map(
//                             (e) => Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ListItemHome(product: e),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
