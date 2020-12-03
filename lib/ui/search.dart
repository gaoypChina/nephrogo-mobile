import 'package:flutter/material.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/ui/tabs/nutrition/nutrition_tab.dart';

Future<Product> showProductSearch(BuildContext context) async {
  final product = await showSearch(
      context: context,
      delegate: ProductSearchDelegate(
        hintText: "Įveskite valgį ar gėrimą...",
      ));
  return product;
}

class ProductTile extends StatelessWidget {
  final Product product;
  final GestureTapCallback onTap;

  const ProductTile({
    Key key,
    @required this.product,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      leading: ProductKindIcon(
        productKind: product.kind,
      ),
      onTap: onTap,
    );
  }
}

class ProductSearchDelegate extends SearchDelegate<Product> {
  ProductSearchDelegate({
    String hintText,
  }) : super(searchFieldLabel: hintText);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _searchForProduct(context, query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _searchForProduct(context, query);
  }

  Widget _searchForProduct(BuildContext context, String query) {
    final results = Product.generateDummies();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];

        return ProductTile(
          product: product,
          onTap: () => close(context, product),
        );
      },
    );
  }
}
