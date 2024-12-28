import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  static const routeName = "/edit-product";

  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _form = GlobalKey<FormState>();
  final _formImg = GlobalKey<FormState>();
  var _hasImg = true;
  var _init = true;

  var _product = Product(
    id: '',
    title: '',
    price: 0.0,
    des: '',
    imgUrl: '',
  );

  void _openInputImgeUrl(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Form(
            key: _formImg,
            child: TextFormField(
              initialValue: _product.imgUrl,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Rasim URL'),
              keyboardType: TextInputType.url,
              onSaved: (newValeu) {
                _product = Product(
                  id: _product.id,
                  title: _product.title,
                  price: _product.price,
                  des: _product.des,
                  imgUrl: newValeu!,
                  isFavorite: _product.isFavorite,
                );
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Rasim URl ni kiriting!';
                } else if (!value.startsWith('http')) {
                  return "Rasim URl xato";
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Bekor qilish"),
            ),
            ElevatedButton(
              onPressed: () {
                _saveImg(context);
              },
              child: const Text("Saqlash"),
            ),
          ],
        );
      },
    );
  }

  void _saveForm() {
    bool isDone = _form.currentState!.validate();

    FocusScope.of(context).unfocus();

    setState(() {
      _hasImg = _product.imgUrl.isNotEmpty;
    });

    if (isDone && _hasImg) {
      _form.currentState!.save();
      if (_product.id.isEmpty) {
        Provider.of<Products>(context, listen: false).addNewProduct(_product);
      } else {
        Provider.of<Products>(context, listen: false).editProduct(_product);
      }
      Navigator.of(context).pop();
    }
  }

  void _saveImg(BuildContext context) {
    bool isDone1 = _formImg.currentState!.validate();
    if (isDone1) {
      _formImg.currentState!.save();
      setState(() {
        _hasImg = true;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_init) {
      final newProdectId = ModalRoute.of(context)!.settings.arguments;
      // ignore: unnecessary_null_comparison
      if (newProdectId != null) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _editProduct = Provider.of<Products>(context, listen: false)
            .findById(newProdectId as String);
        _product = _editProduct;
      }
    }
    _init = false;
  }

  // final _priceFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save_rounded),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: _product.title,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Name"),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (newValeu) {
                    _product = Product(
                      id: _product.id,
                      title: newValeu!,
                      price: _product.price,
                      des: _product.des,
                      imgUrl: _product.imgUrl,
                      isFavorite: _product.isFavorite,
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Maxsulot nomi to\'liq kiritilinmagan!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: _product.price.toString(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Price"),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onSaved: (newValeu) {
                    _product = Product(
                      id: _product.id,
                      title: _product.title,
                      price: double.parse(newValeu!),
                      des: _product.des,
                      imgUrl: _product.imgUrl,
                      isFavorite: _product.isFavorite,
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bo\'sh bo\'lidhi mumkin emas';
                    } else if (double.tryParse(value) == null) {
                      return 'Raqam ko\'rinishida kiriting';
                    } else if (double.parse(value) <= 0) {
                      return '0 dan katta bolishi kerak!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: _product.des,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Description"),
                    alignLabelWithHint: true,
                  ),
                  onSaved: (newValeu) {
                    _product = Product(
                      id: _product.id,
                      title: _product.title,
                      price: _product.price,
                      des: newValeu!,
                      imgUrl: _product.imgUrl,
                      isFavorite: _product.isFavorite,
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bo\'sh qolmasligi kerak!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Card(
                  margin: EdgeInsets.zero,
                  child: InkWell(
                    onTap: () => _openInputImgeUrl(context),
                    borderRadius: BorderRadius.circular(5),
                    splashColor:
                        Theme.of(context).primaryColor.withOpacity(0.5),
                    highlightColor: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: _hasImg ? Colors.grey : Colors.red,
                        ),
                      ),
                      width: double.infinity,
                      height: 200,
                      alignment: Alignment.center,
                      child: _product.imgUrl.isEmpty
                          ? Text(
                              "Asosy rasim URl-ni kiriting",
                              style: TextStyle(
                                color: _hasImg ? Colors.black : Colors.red,
                              ),
                            )
                          : Image.network(
                              _product.imgUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
