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

          if (productos.length == 0) {
            return Center(
              child: Container(
                child: Text('Aún no se han registrado productos'),
              ),
            );
          }

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (_, i) => Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (_) {
                productProvider.destroy(productos[i].id!);
              },
              child: Card(
                child: Column(
                  children: [
                    productos[i].fotourl == null
                        ? Image(
                            image: AssetImage('assets/no-image.png'),
                          )
                        : FadeInImage(
                            placeholder: AssetImage('assets/jar-loading.gif'),
                            image: NetworkImage(productos[i].fotourl!),
                            fit: BoxFit.cover,
                          ),
                    _renderTile(productos, i, context),
                  ],
                ),
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

  ListTile _renderTile(List<Product> productos, int i, BuildContext context) {
    return ListTile(
      title: Text(productos[i].titulo!),
      subtitle: Text(productos[i].precio),
      onTap: () => Navigator.pushNamed(
        context,
        'product',
        arguments: productos[i],
      ),
    );
  }
}
