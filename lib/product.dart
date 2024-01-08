import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'perennial-futures.000webhostapp.com';

class Product {
  String _image;
  int _Rid;
  String _name;
  String _price;
  int _cat;
  String _buy;

  Product(
      this._image, this._Rid, this._name, this._price, this._cat, this._buy);

  @override
  String toString() {
    return """
    
    Resistor id:$_Rid
    Resistor name:$_name
    Resistor category:$_cat
    Resistor buying status:$_buy
    
    """
        "";
  }
}

// list to hold products retrieved from getProducts
List<Product> _products = [];
// asynchronously update _products list
void updateProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getProducts.php');
    final response = await http
        .get(url)
        .timeout(const Duration(seconds: 30)); // max timeout 5 seconds
    _products.clear(); // clear old products
    if (response.statusCode == 200) {
      // if successful call
      final jsonResponse = convert
          .jsonDecode(response.body); // create dart json object from json array
      for (var row in jsonResponse) {
        // iterate over all rows in the json array
        Product p = Product(row['image'], int.parse(row['Rid']), row['name'],
            row['price'], int.parse(row['cat']), row['buy']);
        _products.add(p); // add the product object to the _products list
      }
      update(
          true); // callback update method to inform that we completed retrieving data
    }
  } catch (e) {
    update(false); // inform through callback that we failed to get data
  }
}

// searches for a single product using product pid

void searchProduct(Function(String text) update, int pid) async {
  try {
    final url = Uri.https(_baseURL, 'selectedProduct.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _products.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var row = jsonResponse[0];
      Product p = Product(row['image'], int.parse(row['Rid']), row['name'],
          row['price'], int.parse(row['cat']), row['buy']);
      _products.add(p);
      update(p.toString());
    }
  } catch (e) {
    update("can't load data");
  }
}
// shows products stored in the _products list as a ListView

class ShowProducts extends StatefulWidget {
  const ShowProducts({super.key});

  @override
  State<ShowProducts> createState() => _ShowProductsState();
}

class _ShowProductsState extends State<ShowProducts> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            color: Colors.grey[200],
            child: Column(children: [
              const SizedBox(
                height: 5,
                width: double.infinity,
              ),
              Row(children: [
                Image.network(_products[index]._image, width: 100),
                Text(_products[index].toString(),
                    style: const TextStyle(fontSize: 11)),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Products(),
                              settings: RouteSettings(
                                  arguments: _products[index]._price)));
                        });
                      },
                      child: Text("View Price")),
                )
              ]),
              const SizedBox(height: 5)
            ]),
          );
        });
  }
}

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    String price = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Resistor choosed:"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "The price is $price",
                  style: TextStyle(color: Colors.lightBlue, fontSize: 30),
                ),
              ),
              Center(
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("Buy Now"))),
              SizedBox(
                height: 20,
              ),
              Text(
                  "Please Save The Rid  Number to Buy this Resistor Number!!! ",
                  style: TextStyle(color: Colors.black, fontSize: 15)),
              SizedBox(
                height: 20,
              ),
              Text("Open From Monday To Friday From 8 a.m Till 5 p.m",
                  style: TextStyle(color: Colors.black, fontSize: 15)),
              SizedBox(
                height: 20,
              ),
              Text("Saida-Telephone Number :+961 76 045 280",
                  style: TextStyle(color: Colors.black, fontSize: 15))
            ],
          ),
        ));
  }
}
