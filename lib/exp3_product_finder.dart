// Exp 3: Product Finder - live search + category filter chips.
import 'package:flutter/material.dart';

void main() {
  List items = [
    ['Cotton T-Shirt', 'Clothing', 499],
    ['Denim Jeans', 'Clothing', 1299],
    ['Running Shoes', 'Footwear', 2199],
    ['Leather Sandals', 'Footwear', 899],
    ['Wireless Earbuds', 'Electronics', 1999],
    ['Power Bank', 'Electronics', 1099],
    ['Smart Band', 'Electronics', 2499],
    ['Flutter in Action', 'Books', 650],
    ['Clean Code', 'Books', 720],
    ['Water Bottle', 'Home', 349],
  ];
  var cats = ['All', 'Clothing', 'Footwear', 'Electronics', 'Books', 'Home'];
  var ctrl = TextEditingController();
  var query = '';
  var selected = 'All';

  runApp(
    MaterialApp(
      home: StatefulBuilder(
        builder: (context, setState) {
          var results = items
              .where(
                (i) =>
                    i[0].toLowerCase().contains(query.toLowerCase()) &&
                    (selected == 'All' || i[1] == selected),
              )
              .toList();

          return Scaffold(
            appBar: AppBar(title: Text('Product Finder')),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    controller: ctrl,
                    onChanged: (v) => setState(() => query = v),
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      suffixIcon: query.isEmpty
                          ? null
                          : IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                ctrl.clear();
                                setState(() => query = '');
                              },
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var c in cats)
                        Padding(
                          padding: EdgeInsets.all(4),
                          child: ChoiceChip(
                            label: Text(c),
                            selected: selected == c,
                            onSelected: (_) => setState(() => selected = c),
                          ),
                        ),
                    ],
                  ),
                ),
                Text('${results.length} product(s) found'),
                Expanded(
                  child: results.isEmpty
                      ? Center(child: Text('No matching products'))
                      : ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, i) => Card(
                            child: ListTile(
                              title: Text(results[i][0]),
                              subtitle: Text(results[i][1]),
                              trailing: Text('₹${results[i][2]}'),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
