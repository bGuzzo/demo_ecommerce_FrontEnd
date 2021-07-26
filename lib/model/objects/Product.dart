class Product {
  int id;
  String name;
  String barCode;
  String description;
  double price;
  int quantity;
  String category;

  Product(
      {this.id,
      this.name,
      this.barCode,
      this.description,
      this.price,
      this.quantity,
      this.category});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['nome'],
        barCode: json['bar_code'],
        description: json['descrizione'],
        price: json['prezzo'],
        quantity: json['quantita'],
        category: json['categoria']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'bar_code': barCode,
        'descrizione': description,
        'prezzo': price,
        'quantita': quantity,
        'categoria': category
      };

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
