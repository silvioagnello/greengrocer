import '../base/models/item_model.dart';

class CategoryModel {
  //
  String id;
  String title;

  List<ItemModel> items;
  int pagination;

  CategoryModel({
    required this.id,
    required this.title,
    required this.items,
    required this.pagination,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        title: json['title'],
        id: json['id'],
        items: (json['items'] as List<dynamic>?)
                ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        pagination: json['pagination'] as int? ?? 0,
      );

  Map<String, dynamic> toJson(CategoryModel instance) => <String, dynamic>{
        'title': instance.title,
        'id': instance.id,
        'items': instance.items,
        'pagination': instance.pagination,
      };

  @override
  String toString() {
    return 'CategoryModel{id: $id, title: $title, items: $items, pagination: $pagination}';
  }
}
