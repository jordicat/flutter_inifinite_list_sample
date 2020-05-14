import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'catalog.dart';
import 'src/models/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Catalog>(
      create: (context) => Catalog(),
      child: MaterialApp(
        title: 'Inifinite List Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CatalogPage(),
      ),
    );
  }
}

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Infinite List Sample')),
      body: Selector<Catalog, int>(
        builder: (context, itemCount, child) => ListView.builder(
          itemCount: itemCount,
          padding: const EdgeInsets.symmetric(vertical: 18),
          itemBuilder: (context, index) {
            var catalog = Provider.of<Catalog>(context);
            var item = catalog.getByIndex(index);

            if (item.isLoading) {
              return LoadingItemTile();
            }

            return ItemTile(item: item);
          },
        ),
        selector: (context, catalog) => catalog.itemCount,
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final Item item;

  const ItemTile({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: Container(
            color: item.color,
          ),
        ),
        title: Text(
          item.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        trailing: Text('${(item.price / 100).toStringAsFixed(2)}€'),
      ),
    );
  }
}

class LoadingItemTile extends StatelessWidget {
  const LoadingItemTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: Placeholder(),
        ),
        title: Text(
          'Loading...',
          style: Theme.of(context).textTheme.headline6,
        ),
        trailing: Text('NA'),
      ),
    );
  }
}
