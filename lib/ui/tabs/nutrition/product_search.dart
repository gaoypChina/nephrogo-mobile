import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/utils/utils.dart';
import 'package:nephrogo_api_client/model/product.dart';
import 'package:stream_transform/stream_transform.dart';

import 'intake_create.dart';

enum ProductSearchType {
  choose,
  change,
}

class _Query {
  final String query;
  final bool wait;

  _Query(this.query, {@required this.wait});
}

class ProductSearchScreen extends StatefulWidget {
  final ProductSearchType searchType;

  const ProductSearchScreen({
    Key key,
    @required this.searchType,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState<T> extends State<ProductSearchScreen> {
  final _apiService = ApiService();

  final _searchDispatchDuration = Duration(milliseconds: 200);

  String currentQuery = '';
  final focusNode = FocusNode();

  final _queryStreamController = StreamController<_Query>.broadcast();

  @override
  void dispose() {
    super.dispose();

    focusNode.dispose();
    _queryStreamController.close();
  }

  Stream<List<Product>> _buildStream() {
    return _queryStreamController.stream
        .startWith(_Query('', wait: false))
        .asyncMap((q) async {
          if (q.wait) {
            await Future.delayed(_searchDispatchDuration);
          }
          return q.query;
        })
        .where((q) => q == currentQuery)
        .asyncMap((q) => _apiService.getProducts(q));
  }

  void _changeQuery(String query) {
    currentQuery = query.trim();

    if (currentQuery.isEmpty || currentQuery.length >= 3) {
      _queryStreamController.add(_Query(currentQuery, wait: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final baseTheme = Theme.of(context);
    final theme = baseTheme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: baseTheme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.dark,
      primaryTextTheme: baseTheme.textTheme,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        iconTheme: theme.primaryIconTheme,
        textTheme: theme.primaryTextTheme,
        brightness: theme.primaryColorBrightness,
        title: TextField(
          onChanged: _changeQuery,
          focusNode: focusNode,
          style: theme.textTheme.headline6,
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.text,
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: appLocalizations.productSearchTitle,
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Column(
          children: [
            Expanded(
              child: AppStreamBuilder<List<Product>>(
                stream: _buildStream(),
                builder: (context, products) {
                  return Visibility(
                    visible: products.isNotEmpty,
                    replacement: SingleChildScrollView(
                      child: EmptyStateContainer(
                        text: appLocalizations.productSearchEmpty(currentQuery),
                      ),
                    ),
                    child: ListView.separated(
                      itemCount: products.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(height: 1),
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return ProductTile(
                          product: product,
                          onTap: () => close(context, product),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            BasicSection(
              padding: EdgeInsets.only(top: 8),
              children: [
                AppListTile(
                  title: Text(appLocalizations.searchUnableToFindProduct),
                  trailing: OutlinedButton(
                    onPressed: _reportMissingProduct,
                    child: Text(appLocalizations.report.toUpperCase()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _reportMissingProduct() {
    return launchURL(Constants.reportMissingProductUrl);
  }

  Future close(BuildContext context, Product product) async {
    if (widget.searchType == ProductSearchType.choose) {
      return Navigator.of(context).pushReplacementNamed(
        Routes.routeIntakeCreate,
        arguments: IntakeCreateScreenArguments(product: product),
      );
    }

    Navigator.pop(context, product);
  }
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
    return AppListTile(
      key: ObjectKey(product),
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      title: Text(product.name),
      leading: ProductKindIcon(
        productKind: product.productKind,
      ),
      onTap: onTap,
    );
  }
}
