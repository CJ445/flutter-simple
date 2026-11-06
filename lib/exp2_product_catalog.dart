// Exp 2: Product Catalog - responsive grid using LayoutBuilder.
import 'package:flutter/material.dart';

void main() {
  List products = [
    ['Headphones', 'Audio', 2499, 4.5, Icons.headphones],
    ['Smart Watch', 'Wearables', 3999, 4.2, Icons.watch],
    ['Speaker', 'Audio', 1799, 4.4, Icons.speaker],
    ['Android Phone', 'Mobiles', 15999, 4.6, Icons.phone_android],
    ['Laptop', 'Computers', 54999, 4.7, Icons.laptop_mac],
    ['DSLR Camera', 'Cameras', 42999, 4.8, Icons.camera_alt],
    ['Keyboard', 'Accessories', 1299, 4.1, Icons.keyboard],
    ['Gaming Mouse', 'Accessories', 899, 4.3, Icons.mouse],
  ];
  List categories = ['All', 'Audio', 'Mobiles', 'Computers', 'Wearables'];

  Widget productCard(p) => Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Center(child: Icon(p[4], size: 60))),
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p[0]),
              Text(p[1]),
              Text('Rating: ${p[3]}'),
              Text('₹${p[2]}'),
            ],
          ),
        ),
      ],
    ),
  );

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ShopEase Catalog')),
        body: LayoutBuilder(
          builder: (context, box) {
            double w = box.maxWidth;

            var grid = GridView.builder(
              padding: EdgeInsets.all(12),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: w < 600 ? 2 : (w < 1000 ? 3 : 4),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, i) => productCard(products[i]),
            );

            if (w < 1000) return grid;
            return Row(
              children: [
                SizedBox(
                  width: 200,
                  child: ListView(
                    children: [
                      for (var c in categories) ListTile(title: Text(c)),
                    ],
                  ),
                ),
                Expanded(child: grid),
              ],
            );
          },
        ),
      ),
    ),
  );
}
