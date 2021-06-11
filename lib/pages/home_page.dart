import 'package:flutter/material.dart';
import 'package:patron_bloc/blocs/provider.dart';
import 'package:patron_bloc/models/product_model.dart';
import 'package:patron_bloc/providers/products_provider.dart';

class HomePage extends StatelessWidget {
  final ProductsProvider productProvider = ProductsProvider();

  @override
  Widget build(BuildContext context) {
    final LoginBloc bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: FutureBuilder(
        future: productProvider.index(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final productos = snapshot.data!;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (_, i) => Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (_) {
                // To do: Eliminar producto
              },
              child: ListTile(
                title: Text(productos[i].titulo!),
                subtitle: Text(productos[i].precio),
                onTap: () => Navigator.pushNamed(context, 'product'),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'product'),
        child: Icon(Icons.add),
      ),
    );
  }
}
