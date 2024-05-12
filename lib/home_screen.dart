import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_bag/class_product_variant.dart';
import 'class_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> products = getProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: IconButton(
              onPressed: () {
                //do something
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 50,
            margin: const EdgeInsets.only(top: 40, left: 14),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'My Bag',
                style: TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 34,
                  color: Colors.black87,
                  height: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    child: ListTile(
                      leading: SizedBox(
                        height: 100, //double.infinity,
                        width: 100, //MediaQuery.of(context).size.width * 0.3,
                        child: Image.network(
                          products[index].imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[index].productName,
                            style: const TextStyle(
                                fontFamily: 'Metropolis',
                                fontSize: 20,
                                color: Colors.black87,
                                height: 1),
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Color: '),
                                    TextSpan(
                                      text: products[index].variants.color,
                                      style: const TextStyle(
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Size: '),
                                    TextSpan(
                                      text: products[index].variants.size,
                                      style: const TextStyle(
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (products[index].quantity > 1) {
                                          products[index].quantity--;
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        elevation: 5),
                                    child: const Icon(Icons.remove),
                                  ),
                                  Text(
                                    '${products[index].quantity}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          products[index].quantity++;
                                          if (products[index].quantity == 5) {
                                            _showDialog(
                                              products[index].quantity,
                                              products[index].productName,
                                            );
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder(),
                                          elevation: 5),
                                      child: const Icon(Icons.add)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.more_vert),
                          Text(
                            '\$${products[index].productPrice}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Metropolis',
                              height: 1,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _showDialog(int count, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'You have added $count $name to your bag',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const SizedBox(
              width: double.infinity,
              child: Text(
                'Okay',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Product> getProducts() {
    return [
      Product(
          productName: 'Pullover',
          quantity: 1,
          variants: ProductVariant(color: 'Red', size: 'L'),
          imageUrl:
              'https://images.pexels.com/photos/12967/pexels-photo-12967.jpeg',
          productPrice: 19.2 ),
      Product(
          quantity: 3,
          productName: 'T-Shirt',
          variants: ProductVariant(color: 'Blue', size: 'L'),
          imageUrl:
              'https://images.pexels.com/photos/428338/pexels-photo-428338.jpeg',
          productPrice: 30.2 ),
      Product(
          quantity: 2,
          productName: 'Sports Dress',
          variants: ProductVariant(color: 'Green', size: 'L'),
          imageUrl:
              'https://images.pexels.com/photos/5560771/pexels-photo-5560771.jpeg',
          productPrice: 49.2 )
    ];
  }
}
