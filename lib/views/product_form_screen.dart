import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/products_provider.dart';

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _fomData = Map<String, Object?>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print('arguments: ${ModalRoute.of(context)!.settings.arguments}');

    if (_fomData.isEmpty) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final product = ModalRoute.of(context)!.settings.arguments as Product;

        _fomData['id'] = product.id;
        _fomData['title'] = product.title;
        _fomData['description'] = product.description;
        _fomData['price'] = product.price;
        _fomData['imageUrl'] = product.imageUrl;

        // Como o textField possui um controller.
        // o campo deve ser preenchido pelo controller.
        // Se colocar o initialValue no TextField vai dar erro
        _imageUrlController.text = product.imageUrl;
      } else {
        _fomData['id'] = null;
        _fomData['title'] = "";
        _fomData['description'] = "";
        _fomData['price'] = "";
        _fomData['imageUrl'] = "";
      }
    }
  }

  void _updateImage() {
    if (isValidUrlImage(_imageUrlController.text)) {
      setState(() {});
    }
  }

  bool isValidUrlImage(String url) {
    bool isValidProtocol = url.toLowerCase().startsWith('http://') ||
        url.toLowerCase().startsWith('https://');

    bool isValidImage = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return (isValidProtocol && isValidImage);
  }

  String? getProductId() {
    if (_fomData['id'] != null) {
      return _fomData['id'].toString();
    }

    return null;
  }

  void _saveForm() {
    var isValid = _form.currentState!.validate();

    if (isValid) {
      _form.currentState!.save();
      print(_fomData.values);

      final newProduct = Product(
        id: getProductId(),
        title: _fomData['title'].toString(),
        description: _fomData['description'].toString(),
        price: double.parse(_fomData['price'].toString()),
        imageUrl: _fomData['imageUrl'].toString(),
      );

      print(newProduct.id);
      print(newProduct.title);
      print(newProduct.description);
      print(newProduct.price);
      print(newProduct.imageUrl);

      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);

      if (newProduct.id == null) {
        productProvider.addProduct(newProduct);
      } else {
        productProvider.updateProduct(newProduct);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImage);
    _imageUrlFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Produto"),
        actions: [
          IconButton(
            onPressed: () {
              _saveForm();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                  decoration: InputDecoration(labelText: 'Título'),
                  // Para definir o próximo foco após o enter
                  textInputAction: TextInputAction.next,
                  initialValue: _fomData['title'].toString(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o título do produto';
                    }

                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  // validator: (value) { return (value != null && value.isEmpty); },
                  onSaved: (value) => _fomData['title'] = value!),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                focusNode: _priceFocusNode,
                textInputAction: TextInputAction.next,
                initialValue: _fomData['price'].toString(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o preço do produto';
                  }

                  double? valor = double.tryParse(value);
                  if (valor == null || valor <= 0) {
                    return 'Preço do produto incorreto';
                  }

                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) => _fomData['price'] = double.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                initialValue: _fomData['description'].toString(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe a Descrição do produto';
                  }

                  return null;
                },
                onSaved: (value) => _fomData['description'] = value!,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Url Imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocusNode,
                      controller: _imageUrlController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe a Url da Imagem do produto';
                        }

                        if (!isValidUrlImage(value)) {
                          return 'Informe uma url Válida';
                        }

                        return null;
                      },
                      onSaved: (value) => _fomData['imageUrl'] = value!,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 8, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? Text("Informe a URL")
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
