import 'item.dart';

class Items {
  List<Item>? itemList;

  Items({this.itemList});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      itemList = <Item>[];
      json['items'].forEach((v) {
        itemList!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemList != null) {
      data['items'] = this.itemList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
