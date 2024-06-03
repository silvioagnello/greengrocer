import 'package:freezed_annotation/freezed_annotation.dart';

import '../../cart/models/cart_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;

  @JsonKey(name: 'createdAt')
  DateTime? createdDateTime;

  @JsonKey(name: 'due')
  DateTime overdueDateTime;

  @JsonKey(defaultValue: [])
  List<CartItemModel> items;

  String status;
  String? qrCodeImage;

  @JsonKey(name: 'copiaecola')
  String copyAndPaste;
  double total;

  OrderModel(
    this.id,
    this.createdDateTime,
    this.overdueDateTime,
    this.items,
    this.status,
    this.qrCodeImage,
    this.copyAndPaste,
    this.total,
  );

  bool get isOverDue => overdueDateTime.isBefore(DateTime.now());

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
