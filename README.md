# flutter-simple

Five small Flutter lab experiments, each a single self-contained `main.dart`-style
file in [`lib/`](lib). Every file has its own `main()`, so you run whichever one
you want with the `-t` (target) flag.

| # | Experiment | File | Concepts |
|---|------------|------|----------|
| 1 | Fruit Basket | [`exp1_fruit_basket.dart`](lib/exp1_fruit_basket.dart) | `Scaffold`, `Card`, `Row`/`Column`, `ListView.builder` |
| 2 | Product Catalog | [`exp2_product_catalog.dart`](lib/exp2_product_catalog.dart) | Responsive layout with `LayoutBuilder`, `GridView.builder`, side panel on wide screens |
| 3 | Product Finder | [`exp3_product_finder.dart`](lib/exp3_product_finder.dart) | `StatefulBuilder`, live search, `ChoiceChip` category filter |
| 4 | Car Mileage Calculator | [`exp4_mileage_calculator.dart`](lib/exp4_mileage_calculator.dart) | `Form`, `TextFormField` validators, `DropdownButtonFormField` |
| 5 | Personal Budget Calculator | [`exp5_budget_calculator.dart`](lib/exp5_budget_calculator.dart) | State management with `provider` (`ChangeNotifier`, `Consumer`) |

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (developed on 3.47, stable channel)
- Chrome (web target)

## Getting started

```bash
git clone https://github.com/CJ445/flutter-simple.git
cd flutter-simple
flutter pub get
```

## Running an experiment

```bash
flutter run -t lib/exp1_fruit_basket.dart
flutter run -t lib/exp2_product_catalog.dart
flutter run -t lib/exp3_product_finder.dart
flutter run -t lib/exp4_mileage_calculator.dart
flutter run -t lib/exp5_budget_calculator.dart
```

Only the web platform is included, so add `-d chrome`. Experiment 2 is
best viewed in a resizable window: the grid goes 2 → 3 → 4 columns and a
category sidebar appears at 1000 px width and above.

## Experiment notes

1. **Fruit Basket** – a green header banner plus a scrolling list of fruit cards (name, origin, price per kg).
2. **Product Catalog** – a grid of product cards whose column count adapts to screen width.
3. **Product Finder** – type to filter by name, tap a chip to filter by category; shows a result count and an empty state.
4. **Car Mileage Calculator** – validates every field (required, numeric, > 0, end odometer > start), then reports km/l, a rating (Excellent / Good / Average / Poor), distance and cost per km.
5. **Personal Budget Calculator** – set income, add/remove expenses; a progress bar and status ("Healthy Budget", "Low Savings", "Over Budget") update through `provider`. Needs the `provider` package (already in `pubspec.yaml`).

## Known limitations

These are lab-style demos, kept intentionally minimal:

- Experiment 5 calls `double.parse` on raw input, so submitting an empty or non-numeric income/amount throws.
- Experiment 2's category list is display-only (it does not filter).
- Data is hard-coded; nothing is persisted.

## Project structure

```
lib/
  exp1_fruit_basket.dart
  exp2_product_catalog.dart
  exp3_product_finder.dart
  exp4_mileage_calculator.dart
  exp5_budget_calculator.dart
pubspec.yaml
```
