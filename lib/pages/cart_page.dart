import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void removeNavigator(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(
    //   Provider.of<String>(context),
    // );
    debugPrint(Provider.of<CartProvider>(context).cart.toString());
    final cart = context.watch<CartProvider>().cart;
    // final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Cart",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: cart.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.remove_shopping_cart,
                    size: 40,
                  ),
                  Text(
                    "Cart Empty",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final cartItem = cart[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(cartItem['imgurl'] as String),
                  ),
                  title: Text(
                    cartItem['title'].toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text('Size : ${cartItem['size']}'),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Delete Product",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              content: const Text(
                                "Are yor sure, you want to delete product from your cart?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    removeNavigator(context);
                                  },
                                  style: const ButtonStyle(),
                                  child: const Text(
                                    "No",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context
                                        .read<CartProvider>()
                                        .removeProduct(cartItem);
                                    // Provider.of<CartProvider>(context,
                                    //         listen: false)
                                    //     .removeProduct(cartItem);
                                    removeNavigator(context);
                                  },
                                  child: const Text(
                                    "Yes",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
              }),
      // body: const Column(
      //   children: <Widget>[
      //     CartItem(
      //       imgUrl: 'assets/images/shoes_1.png',
      //       title: "title",
      //       size: 23.4,
      //     ),
      //     CartItem(
      //       imgUrl: 'assets/images/shoes_1.png',
      //       title: "title",
      //       size: 23.4,
      //     ),
      //     CartItem(
      //       imgUrl: 'assets/images/shoes_1.png',
      //       title: "title",
      //       size: 23.4,
      //     ),
      //   ],
      // ),
    );
  }
}
