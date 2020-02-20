import 'package:ProcureCentre/extraction/entities/data_entity.dart';
import 'package:meta/meta.dart';

@immutable
class DataPoint {
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

  DataPoint(
      {String id,
      String invoice,
      String order,
      String date,
      String currency,
      String supplier,
      String customer,
      String code,
      String description,
      String qty,
      String uom,
      String price,
      String base,
      String total})
      : this.id = id,
        this.invoice = invoice,
        this.order = order,
        this.date = date,
        this.currency = currency,
        this.customer = customer,
        this.supplier = supplier,
        this.code = code,
        this.description = description,
        this.qty = qty,
        this.uom = uom,
        this.price = price,
        this.base = base,
        this.total = total;

  DataPoint copyWith({
    String invoice,
    String order,
    String id,
    String date,
    String description,
    String currency,
    String customer,
    String supplier,
    String code,
    String qty,
    String uom,
    String price,
    String base,
  }) {
    return DataPoint(
        invoice: invoice ?? this.invoice,
        order: order ?? this.order,
        id: id ?? this.id,
        date: date ?? this.date,
        description: description ?? this.description,
        currency: currency ?? this.currency,
        customer: customer ?? this.customer,
        supplier: supplier ?? this.supplier,
        code: code ?? this.code,
        qty: qty ?? this.qty,
        uom: uom ?? this.uom,
        price: price ?? this.price,
        base: base ?? this.base,
        total: total ?? this.total);
  }

  @override
  int get hashCode =>
      order.hashCode ^
      invoice.hashCode ^
      date.hashCode ^
      id.hashCode ^
      description.hashCode ^
      currency.hashCode ^
      customer.hashCode ^
      supplier.hashCode ^
      code.hashCode ^
      qty.hashCode ^
      uom.hashCode ^
      price.hashCode ^
      base.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataPoint &&
          runtimeType == other.runtimeType &&
          order == other.order &&
          invoice == other.invoice &&
          date == other.date &&
          id == other.id &&
          description == other.id &&
          currency == other.currency &&
          customer == other.customer &&
          supplier == other.supplier &&
          code == other.code &&
          uom == other.uom &&
          qty == other.qty &&
          price == other.price &&
          base == other.base &&
          total == other.total;

  @override
  String toString() {
    return 'DataPoint{order: $order, invoice: $invoice, date: $date, id: $id, description: $description, currency: $currency, customer: $customer}';
  }

  DataEntity toEntity() {
    return DataEntity(id, invoice, order, date, currency, supplier, customer,
        code, description, qty, uom, price, base, total);
  }

  static DataPoint fromJson(Map<String, Object> json) {
    return DataPoint(
      invoice: json["Invoice ID"],
      order: json["Order ID"],
      date: json['Date'],
      currency: json['Currency'],
      supplier: json['Supplier'],
      customer: json['Customer'],
      code: json['item_code'],
      description: json['item_description'] as String,
      qty: json['item_quantity'] as String,
      uom: json['item_uom'] as String,
      price: json['item_amount_base'] as String,
      base: ['item_total_base'] as String,
      total: ['item_amount_total'] as String,
    );
  }

  static DataPoint fromEntity(DataEntity entity) {
    return DataPoint(
        invoice: entity.invoice,
        order: entity.order ?? false,
        date: entity.date,
        id: entity.id,
        description: entity.description,
        currency: entity.currency,
        customer: entity.customer,
        supplier: entity.supplier,
        code: entity.code,
        qty: entity.qty,
        uom: entity.uom,
        price: entity.price,
        base: entity.base,
        total: entity.total
        //data: entity.data,

        );
  }
}
