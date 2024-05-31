class ItemModel {
  String id;
  String itemName;
  String imgUrl;
  String unit;
  double price;
  String description;

  ItemModel({
    this.id = '',
    required this.itemName,
    required this.imgUrl,
    required this.unit,
    required this.price,
    required this.description,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json['id'],
        itemName: json['title'],
        description: json['description'],
        price: double.parse(json['price'].toString()),
        unit: json['unit'],
        imgUrl: json['picture'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = itemName;
    data['description'] = description;
    data['price'] = price;
    data['unit'] = unit;
    data['picture'] = imgUrl;

    return data;
  }

  @override
  String toString() {
    return 'ItemModel{id: $id, itemName: $itemName, imgUrl: $imgUrl, unit: $unit, price: $price, description: $description}';
  }
}
