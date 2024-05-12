import 'package:flutter/material.dart';
import 'class_product.dart';
import 'class_product_variant.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomeScreen2> {
  List<Product> products = Product.getProducts();

  @override
  Widget build(BuildContext context) {

    double getTotalPrice() {
      double totalPrice = 0;
      for (var product in products) {
        totalPrice += product.productPrice * product.quantity;
      }
      setState(() {});
      return totalPrice;
    }

    TextEditingController quantityTEController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 200,
              height: 50,
              child: Padding(
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      leading: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        //child: const Text('Image'),
                        child: Image.network(products[index].imageUrl,
                            fit: BoxFit.cover),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(products[index].productName,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Color: ${products[index].variants.color}',
                                  style: const TextStyle(color: Colors.grey)),
                              const SizedBox(width: 10),
                              Text('Size: ${products[index].variants.size}',
                                  style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (products[index].quantity > 1) {
                                        products[index].updateQuantity(
                                            products[index].quantity - 1);
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.remove)),
                              Text(
                                products[index].quantity.toStringAsFixed(0),
                                key: ValueKey<int>(products[index].quantity),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      products[index].updateQuantity(
                                          products[index].quantity + 1);

                                      if (products[index].quantity == 5) {
                                        _showDialog(
                                          products[index].quantity,
                                          products[index].productName,
                                        );
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.add)),
                            ],
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            width: double.infinity,
                            key: ValueKey<double>(products[index].quantity *
                                products[index].productPrice),
                            child: Text(
                                '\$${(products[index].quantity * products[index].productPrice).toStringAsFixed(2)}'),
                          ),
                        ],
                      ),
                      trailing:  IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            products.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 110,
        child: Wrap(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(fontSize: 18,color: Colors.grey),
                ),
                Text(
                  '\$${getTotalPrice().toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24),
                  key: ValueKey<double>(getTotalPrice()),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Congratulations! Your order has been placed'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  elevation: 5,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('CHECK OUT',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(int count, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Column(
            children: [
              const Text(
                'Congratulation!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight:FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'You have added\n $count\n $name to your bag!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight:FontWeight.w400,
                  fontSize: 18,
                ),
              ),
            ],
          ),
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
}
