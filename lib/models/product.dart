class Product {
  final String productId;
  final String name;
  final double price;
  final double kg;
  final String des;
  final String filePath;
  final String ownerId;

  Product(
      {this.productId,
      this.price,
      this.name,
      this.kg,
      this.des,
      this.filePath,
      this.ownerId});
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'kg': kg,
      'filePath': filePath,
      'ownerId': ownerId,
      'des': des
    };
  }

  Product.fromFirestore(Map<String, dynamic> firestore)
      : productId = firestore['productId'],
        name = firestore['name'],
        price = firestore['price'],
        kg = firestore['kg'],
        filePath = firestore['filePath'],
        ownerId = firestore['ownerId'],
        des = firestore['des'];
}
