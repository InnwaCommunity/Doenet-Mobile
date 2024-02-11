class Customer {
  int? customerId;
  String customerName;
  String customerAddress;
  int? customerTypeId;
  String? customerTypeName;

  Customer({
    this.customerId,
    required this.customerName,
    required this.customerAddress,
    this.customerTypeId,
    this.customerTypeName,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: json['CustomerId'],
      customerName: json['CustomerName'],
      customerAddress: json['CustomerAddress'],
      customerTypeId: json['CustomerTypeId'],
      customerTypeName: json['CustomerTypeName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CustomerId': customerId,
      'CustomerName': customerName,
      'CustomerAddress': customerAddress,
      'CustomerTypeId': customerTypeId,
      'CustomerTypeName': customerTypeName,
    };
  }
}
