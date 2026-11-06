// Exp 1: Fruit Basket - basic layout with Card, Row, Column, ListView.builder.
import 'package:flutter/material.dart';

void main() {
  List fruits = [
    ['Mango', 'Salem, Tamil Nadu', 120],
    ['Banana', 'Theni, Tamil Nadu', 50],
    ['Apple', 'Shimla, Himachal', 180],
    ['Grapes', 'Nashik, Maharashtra', 90],
    ['Orange', 'Nagpur, Maharashtra', 80],
    ['Watermelon', 'Dindigul, Tamil Nadu', 40],
    ['Pineapple', 'Thrissur, Kerala', 70],
  ];

  Widget fruitCard(f) => Card(
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(child: Text(f[0][0])),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(f[0]), Text(f[1])],
            ),
          ),
          Text('₹${f[2]}/kg'),
        ],
      ),
    ),
  );

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Fruit Basket')),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(Icons.shopping_basket, color: Colors.white),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fresh Fruits',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        '${fruits.length} items available today',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: fruits.length,
                itemBuilder: (context, i) => fruitCard(fruits[i]),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
