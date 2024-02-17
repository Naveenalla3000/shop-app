import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String imgUrl;
  final String title;
  final double size;

  const CartItem({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(254, 247, 249, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 2.0),
        child: SizedBox(
          width: double.infinity,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                imgUrl,
                width: 100,
                height: 100,
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      size.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const Spacer(), // Use Spacer to push the delete icon to the end of the row
              const Icon(Icons.delete, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
