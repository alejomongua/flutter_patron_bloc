import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patron_bloc/blocs/provider.dart';
import 'package:patron_bloc/models/product_model.dart';
import 'package:patron_bloc/utils/utils.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  File? foto;

  Product producto = Product();

  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    final ProductsBloc productosBloc = Provider.productsBloc(context);

    final Product? prodData =
        ModalRoute?.of(context)?.settings.arguments as Product?;

    if (prodData != null) {
      producto = prodData;
      print(producto.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
            onPressed: _seleccionarFoto,
            icon: Icon(Icons.image),
          ),
          IconButton(
            onPressed: _tomarFoto,
            icon: Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _showPhoto(),
                _nombreField(),
                _precioField(),
                _crearDisponible(),
                _crearBoton(context, productosBloc),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nombreField() => TextFormField(
        initialValue: producto.titulo,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Producto',
        ),
        onSaved: (value) => producto.titulo = value,
        validator: (value) {
          if (value != null && value.length < 2) {
            return 'Ingrese el nombre del producto';
          }
        },
      );

  Widget _precioField() => TextFormField(
        initialValue: producto.valor == null ? '' : producto.valor.toString(),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Precio',
        ),
        onSaved: (value) =>
            producto.valor = value == null ? 0 : double.parse(value),
        validator: (value) {
          if (!validNumber(value)) {
            return 'Solo se permiten números';
          }
        },
      );

  Widget _crearBoton(BuildContext context, ProductsBloc bloc) => ElevatedButton(
        onPressed: _guardando ? null : () => _submit(context, bloc),
        child: Container(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.save),
              Text('Guardar'),
            ],
          ),
        ),
      );

  _submit(BuildContext context, ProductsBloc bloc) async {
    final currentState = formKey.currentState;
    _guardando = true;
    setState(() {});
    if (currentState != null && currentState.validate()) {
      currentState.save();

      if (foto != null) {
        print('Si hay imagen');
        producto.fotourl = await bloc.addPhoto(foto!);
        print(producto.fotourl);
      }

      bloc.addProduct(producto);

      showSnackbar('Datos guardados');

      Navigator.pop(context);
    }
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      onChanged: (value) {
        producto.disponible = value;
        setState(() {});
      },
    );
  }

  void showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _showPhoto() {
    if (foto != null) {
      return Image.file(
        foto!,
        height: 300,
        fit: BoxFit.cover,
      );
    }

    if (producto.fotourl != null) {
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300,
        image: NetworkImage(producto.fotourl!),
        fit: BoxFit.cover,
      );
    }
    return Image(
      image: AssetImage('assets/no-image.png'),
      height: 300,
      fit: BoxFit.cover,
    );
  }

  void _seleccionarFoto() {
    _pickImage(ImageSource.gallery);
  }

  void _pickImage(source) async {
    final _picker = ImagePicker();

    try {
      final pickedFile = await _picker.getImage(source: source);
      if (pickedFile == null) {
        producto.fotourl = null;
        return;
      }

      foto = File(pickedFile.path);

      print('Imagen seleccionada');
      print(foto!.path);

      setState(() {});
    } catch (PlatformException) {
      showSnackbar('No hay cámaras disponibles en el dispositivo');
    }
  }

  void _tomarFoto() {
    _pickImage(ImageSource.camera);
  }
}
