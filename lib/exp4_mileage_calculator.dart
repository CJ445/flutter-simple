// Exp 4: Car Mileage Calculator - Form, TextFormField validation, Dropdown.
import 'package:flutter/material.dart';

void main() {
  var formKey = GlobalKey<FormState>();
  var start = TextEditingController();
  var end = TextEditingController();
  var fuel = TextEditingController();
  var price = TextEditingController();
  var type = 'Petrol';
  double? distance, mileage, cost;

  String? check(String? v) {
    if (v == null || v.isEmpty) return 'Required';
    var n = double.tryParse(v);
    if (n == null) return 'Enter a valid number';
    if (n <= 0) return 'Must be greater than 0';
    return null;
  }

  String? checkEnd(String? v) {
    if (check(v) != null) return check(v);
    if (double.parse(v!) <= (double.tryParse(start.text) ?? 0)) {
      return 'Must be greater than start';
    }
    return null;
  }

  Widget field(
    TextEditingController c,
    String label, [
    String? Function(String?)? v,
  ]) => Padding(
    padding: EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: c,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: v ?? check,
    ),
  );

  runApp(
    MaterialApp(
      home: StatefulBuilder(
        builder: (context, setState) {
          var rating = '';
          if (mileage != null) {
            rating = mileage! >= 20
                ? 'Excellent'
                : mileage! >= 15
                ? 'Good'
                : mileage! >= 10
                ? 'Average'
                : 'Poor';
          }

          return Scaffold(
            appBar: AppBar(title: Text('Car Mileage Calculator')),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: type,
                      decoration: InputDecoration(
                        labelText: 'Fuel Type',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Petrol', 'Diesel', 'CNG']
                          .map(
                            (f) => DropdownMenuItem(value: f, child: Text(f)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => type = v!),
                    ),
                    SizedBox(height: 12),
                    field(start, 'Start Odometer (km)'),
                    field(end, 'End Odometer (km)', checkEnd),
                    field(fuel, 'Fuel Consumed (litres)'),
                    field(price, 'Fuel Price (₹/litre)'),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            child: Text('Calculate'),
                            onPressed: () {
                              if (!formKey.currentState!.validate()) return;
                              double f = double.parse(fuel.text);
                              double p = double.parse(price.text);
                              setState(() {
                                distance =
                                    double.parse(end.text) -
                                    double.parse(start.text);
                                mileage = distance! / f;
                                cost = f * p / distance!;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            child: Text('Reset'),
                            onPressed: () {
                              formKey.currentState!.reset();
                              start.clear();
                              end.clear();
                              fuel.clear();
                              price.clear();
                              setState(() => mileage = null);
                            },
                          ),
                        ),
                      ],
                    ),
                    if (mileage != null)
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                '${mileage!.toStringAsFixed(2)} km/l',
                                style: TextStyle(fontSize: 30),
                              ),
                              Text('$type mileage • $rating'),
                              Text(
                                'Distance: ${distance!.toStringAsFixed(0)} km',
                              ),
                              Text('Cost / km: ₹${cost!.toStringAsFixed(2)}'),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
