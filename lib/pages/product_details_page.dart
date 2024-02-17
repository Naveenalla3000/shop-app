import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late double selectedSize = 0.0;
  @override
  void initState() {
    super.initState();
    selectedSize = 0.0;
  }

  void onTap() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct(
        {
          'id': widget.product['id'],
          'company': widget.product['company'],
          'title': widget.product['title'],
          'price': widget.product['price'],
          'size': selectedSize,
          'imgurl': widget.product['imgurl'],
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          duration: const Duration(
            milliseconds: 500,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: const Text(
            "Product add to cart!",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          duration: Duration(
            milliseconds: 500,
          ),
          backgroundColor: Colors.red,
          content: Text(
            "You not select the size!",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Details"),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                widget.product['title'] as String,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(widget.product['imgurl'] as String),
            ),
            const Spacer(
              flex: 2,
            ),
            Container(
              // height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(254, 247, 249, 1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\$${widget.product['price']}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          (widget.product['sizes'] as List<double>).length,
                      itemBuilder: (context, index) {
                        final size =
                            (widget.product['sizes'] as List<double>)[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                            child: Chip(
                              backgroundColor: selectedSize == size
                                  ? Theme.of(context).colorScheme.primary
                                  : const Color.fromRGBO(254, 247, 249, 1),
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                              label: Text(
                                size.toString(),
                                style: const TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        "Add to card",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
