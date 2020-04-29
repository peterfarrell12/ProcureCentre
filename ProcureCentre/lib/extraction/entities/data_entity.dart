import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase/firestore.dart' as fs;

class DataEntity extends Equatable {
  final String id;
  final String invoice;
  final String order;
  final String date;
  final String currency;
  final String supplier;
  final String customer;
  final String code;
  final String description;
  final String qty;
  final String uom;
  final String price;
  final String base;
  final String total;
  final String category;

  const DataEntity(
      this.id,
      this.invoice,
      this.order,
      this.date,
      this.currency,
      this.supplier,
      this.customer,
      this.code,
      this.description,
      this.qty,
      this.uom,
      this.price,
      this.base,
      this.total,
      this.category);

  Map<String, dynamic> toJson() => {
        'Invoice ID': invoice,
        'Order ID': order,
        'Date': date,
        'Currency': currency,
        'Supplier': supplier,
        'Customer': customer,
        'item_code': code,
        'item_description': description,
        'item_quantity': qty,
        'item_uom': uom,
        'item_amount_base': price,
        'item_total_base': base,
        'item_amount_total': total,
        'category' : category
      };

  @override
  List<Object> get props => [
    id,
        invoice,
        order,
        date,
        currency,
        supplier,
        customer,
        code,
        description,
        qty,
        uom,
        price,
        base,
        total,
        category
      ];

  @override
  String toString() {
    return 'DataEntity{$invoice}';
  }

  static DataEntity fromJson(Map<String, Object> json) {
    return DataEntity(
      json["id"] as String,
      json["Invoice ID"],
      json["Order ID"],
      json['Date'],
      json['Currency'],
      json['Supplier'],
      json['Customer'],
      json['item_code'],
      json['item_description'] as String,
      json['item_quantity'] as String,
      json['item_uom'] as String,
      json['item_amount_base'] as String,
      json['item_total_base'] as String,
      json['item_amount_total'] as String,
      json['category'] as String
    );
  }

  static DataEntity fromSnapshot(fs.DocumentSnapshot snap) {
    return DataEntity(
        snap.id,
        snap.data()['Invoice ID'],
        snap.data()['Order ID'],
        snap.data()['Date'],
        snap.data()['Currency'],
        snap.data()['Supplier'],
        snap.data()['Customer'],
        snap.data()['item_code'],
        snap.data()['item_description'],
        snap.data()['item_quantity'],
        snap.data()['item_uom'],
        snap.data()['item_amount_base'],
        snap.data()['item_total_base'],
        snap.data()['item_amount_total'],
        snap.data()['category']);
  }

  Map<String, Object> toDocument() {
    return {
      "Invoice ID": invoice,
      "Order ID": order,
      "Date": date,
      "Supplier": supplier,
      "Customer": customer,
      "item_code": code,
      "item_description": description,
      "item_quantity": qty,
      "item_uom": uom,
      "item_amount_base": price,
      'item_total_base': base,
      'item_amount_total': total,
      'category' : category
    };
  }
}
