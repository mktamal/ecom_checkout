import 'class_product_variant.dart';

class Product {
  final String productName;
  final String imageUrl;
  final double productPrice;
  int quantity;
  final ProductVariant variants;

  Product({
    required this.productName,
    required this.variants,
    required this.imageUrl,
    required this.productPrice,
    required this.quantity,
  });

  void updateQuantity(int newQuantity) {
    quantity = newQuantity;
  }

  static List<Product> getProducts() {
    return [
      Product(
          productName: 'Pullover',
          quantity: 1,
          variants: ProductVariant(color: 'Red', size: 'L'),
          imageUrl:
          'https://images.pexels.com/photos/12967/pexels-photo-12967.jpeg',
          productPrice: 51),
      Product(
          quantity: 1,
          productName: 'T-Shirt',
          variants: ProductVariant(color: 'Blue', size: 'L'),
          imageUrl:
          'https://images.pexels.com/photos/428338/pexels-photo-428338.jpeg',
          productPrice: 30),
      Product(
          quantity: 1,
          productName: 'Sports Dress',
          variants: ProductVariant(color: 'Green', size: 'L'),
          imageUrl:
          'https://images.pexels.com/photos/5560771/pexels-photo-5560771.jpeg',
          productPrice: 43)
    ];
  }
}
