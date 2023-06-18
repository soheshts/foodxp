class Item {
  String? name;
  List<String>? hotels;

  Item({this.name, this.hotels});

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    hotels = json['hotels'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['hotels'] = this.hotels;
    return data;
  }
}
