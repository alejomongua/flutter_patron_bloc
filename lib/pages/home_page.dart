import 'package:flutter/material.dart';
import 'package:patron_bloc/blocs/provider.dart';
import 'package:patron_bloc/models/product_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsBloc productosBloc = Provider.productsBloc(context);
    productosBloc.loadProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: createList(productosBloc),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'product'),
        child: Icon(Icons.add),
      ),
    );
  }

  StreamBuilder<List<Product>> createList(ProductsBloc bloc) {
    return StreamBuilder(
      stream: bloc.productosStream,
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
              bloc.removeProduct(productos[i].id!);
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
