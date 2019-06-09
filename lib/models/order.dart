//{"positions":[{"latitude":37.791405,"longitude":-122.398703,"altitude":200.0,"title":"testA","id":"123"},{"latitude":37.3456,"longitude":56.778,"altitude":100.0,"title":"testB","id":"124"}]}

class Order {
  double latitude;
  double longitude;
  String title;
  String id;

  Order(this.latitude, this.longitude, this.title, this.id);

  Order.fromJson(Map<String, dynamic> json) {
    print(json);
    id = json['id'];
    latitude = double.parse(json['latitude']);
    longitude = double.parse(json['longitude']);
    title = json['title'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['title'] = this.title;
    return data;
  }

  static List<Order> listFromJson(List<dynamic> json) {
    return json == null
        ? List<Order>()
        : json.map((value) => Order.fromJson(value)).toList();
  }
}
