import 'dart:collection';

import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'dart:math';

import 'package:intl/intl.dart';

int totalSpend(List<DataPoint> data) {
  double totalSpend = 0;

  for (int i = 0; i < data.length; i++) {
    totalSpend = totalSpend + double.parse(data[i].total);
  }

  return totalSpend.round();
}

int totalSuppliers(List<DataPoint> data) {
  List<String> totalSuppliers = [];

  for (int i = 0; i < data.length; i++) {
    totalSuppliers.add(data[i].supplier);
  }
  var uniqueitems = totalSuppliers.toSet();

  return uniqueitems.length;
}

int totalCategories(List<DataPoint> data) {
  List<String> totalCategories = [];

  for (int i = 0; i < data.length; i++) {
    totalCategories.add(data[i].category);
  }
  var uniqueitems = totalCategories.toSet();

  return uniqueitems.length;
}

String topSupplierspend(List<DataPoint> data) {
  List<String> suppliers = [];
  Map<String, double> supplierSpend = {};
  for (int x = 0; x < data.length; x++) {
    suppliers.add(data[x].supplier);
  }
  print(suppliers.length);

  var categories = suppliers.toSet().toList();

  for (int i = 0; i < categories.length; i++) {
    double categoryTotal = 0;
    for (int j = 0; j < data.length; j++) {
      if (data[j].supplier == categories[i]) {
        categoryTotal = categoryTotal + double.parse(data[j].total);
      }
      supplierSpend[categories[i]] = categoryTotal;
    }
  }

  List<double> spend = [];
  List<String> supp = [];
  supplierSpend.forEach((key, value) {
    spend.add(value);
    supp.add(key);
  });

  int index = spend.indexOf(spend.reduce(max));

  Map<String, double> top = {supp[index]: spend[index]};

  String topSupplier;

  top.forEach((key, value) {
    topSupplier = key.toString();
  });

  return topSupplier;
}

String topItemSpend(List<DataPoint> data) {
  List<String> items = [];
  Map<String, double> itemSpend = {};
  for (int i = 0; i < data.length; i++) {
    items.add(data[i].description);
  }

  var uniqueItem = items.toSet().toList();

  for (int i = 0; i < uniqueItem.length; i++) {
    double itemTotal = 0;
    for (int j = 0; j < data.length; j++) {
      if (data[j].description == uniqueItem[i]) {
        itemTotal = itemTotal + double.parse(data[j].total);
      }
      itemSpend[uniqueItem[i]] = itemTotal;
    }
  }

  List<double> spend = [];
  List<String> item = [];
  itemSpend.forEach((key, value) {
    spend.add(value);
    item.add(key);
  });

  int index = spend.indexOf(spend.reduce(max));

  Map<String, double> top = {item[index]: spend[index]};

  String topItem;

  top.forEach((key, value) {
    topItem = key.toString();
  });

  return topItem;
}

int avgPerInvoice(List<DataPoint> data) {
  List<String> invoices = [];

  for (int i = 0; i < data.length; i++) {
    invoices.add(data[i].invoice);
  }

  var uniqueInvoices = invoices.toSet().toList();
  int spend = totalSpend(data);

  double avgSpend = spend / uniqueInvoices.length;

  return avgSpend.round();
}
List<String> suppliers(List<DataPoint> data){
  List<String> suppliers = [];

  print(data);
  for (int x = 0; x < data.length; x++) {
    suppliers.add(data[x].supplier);
  }

  var categories = suppliers.toSet().toList();

  return categories;
}
List<String> categories(List<DataPoint> data){
  List<String> categories = [];

  print(data);
  for (int x = 0; x < data.length; x++) {
    categories.add(data[x].category);
  }

  var cats = categories.toSet().toList();

  return cats;
}

List<String> location(List<DataPoint> data){
  List<String> location = [];

  print(data);
  for (int x = 0; x < data.length; x++) {
    location.add(data[x].customer);
  }

  var locations = location.toSet().toList();

  return locations;
}

class TopSuppliers {
  final String name;
  final int spend;

  TopSuppliers(this.name, this.spend);
}

List<TopSuppliers> topSupplierData(List<DataPoint> data) {
  print("....");
  List<TopSuppliers> temp = [];
  List<String> suppliers = [];
  Map<String, double> supplierSpend = {};

  print(data);
  for (int x = 0; x < data.length; x++) {
    suppliers.add(data[x].supplier);
    print(data[x].category);
  }

  var categories = suppliers.toSet().toList();

  for (int i = 0; i < categories.length; i++) {
    double categoryTotal = 0;
    for (int j = 0; j < data.length; j++) {
      if (data[j].supplier == categories[i]) {
        categoryTotal = categoryTotal + double.parse(data[j].total);
      }
      supplierSpend[categories[i]] = categoryTotal;
    }
  }

  List<double> spend = [];
  List<String> supp = [];
  supplierSpend.forEach((key, value) {
    spend.add(value);
    supp.add(key);
  });
  print('hello');
  var sortedKeys = supplierSpend.keys.toList(growable: false)
    ..sort((k2, k1) => supplierSpend[k1].compareTo(supplierSpend[k2]));
  LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
      key: (k) => k, value: (k) => supplierSpend[k]);

  sortedMap.forEach((key, value) {
    int newValue = value.round();
    TopSuppliers holder = TopSuppliers(key, newValue);
    temp.add(holder);
  });

  print(temp);

  List<TopSuppliers> top3 = [];

  for (int i = 0; i < 2; i++) {
    top3.add(temp[i]);
  }

  return top3;
}

class CategorySpend {
  final String category;
  final int spend;

  CategorySpend(this.category, this.spend);
}

List<CategorySpend> spendByCategory(List<DataPoint> data) {
  List<String> totalCategories = [];
  List<CategorySpend> temp = [];
  Map<String, double> categorySpend = {};

  for (int x = 0; x < data.length; x++) {
    totalCategories.add(data[x].category);
    print(data[x].category);
  }
  var categories = totalCategories.toSet().toList();

  for (int i = 0; i < categories.length; i++) {
    double categoryTotal = 0;
    for (int j = 0; j < data.length; j++) {
      if (data[j].category == categories[i]) {
        categoryTotal = categoryTotal + double.parse(data[j].total);
      }
      categorySpend[categories[i]] = categoryTotal;
    }
  }

  categorySpend.forEach((key, value) {
    print('$key : $value');
    int newValue = value.round();
    CategorySpend holder = CategorySpend(key, newValue);
    print(holder);
    temp.add(holder);
  });
  print(temp);
  return temp;
}

class LocationSpend {
  final String location;
  final int spend;

  LocationSpend(this.location, this.spend);
}

List<LocationSpend> spendByLocation(List<DataPoint> data) {
  List<String> totalLocations = [];
  List<LocationSpend> temp = [];
  Map<String, double> locationSpend = {};

  for (int x = 0; x < data.length; x++) {
    totalLocations.add(data[x].customer);
    print(data[x].customer);
  }
  var locations = totalLocations.toSet().toList();

  for (int i = 0; i < locations.length; i++) {
    double locationTotal = 0;
    for (int j = 0; j < data.length; j++) {
      if (data[j].customer == locations[i]) {
        locationTotal = locationTotal + double.parse(data[j].total);
      }
      locationSpend[locations[i]] = locationTotal;
    }
  }

  locationSpend.forEach((key, value) {
    print('$key : $value');
    int newValue = value.round();
    LocationSpend holder = LocationSpend(key, newValue);
    print(holder);
    temp.add(holder);
  });
  print(temp);
  return temp;
}

class TopItems {
  final String itemDescription;
  final int spend;

  TopItems(this.itemDescription, this.spend);
}

List<TopItems> topItemsData(List<DataPoint> data) {
  List<TopItems> temp = [];
  List<String> items = [];
  Map<String, double> itemSpend = {};

  print(data);
  for (int x = 0; x < data.length; x++) {
    items.add(data[x].description);
    print(data[x].description);
  }

  var items1 = items.toSet().toList();

  for (int i = 0; i < items1.length; i++) {
    double itemTotal = 0;
    for (int j = 0; j < data.length; j++) {
      if (data[j].description == items1[i]) {
        itemTotal = itemTotal + double.parse(data[j].total);
      }
      itemSpend[items1[i]] = itemTotal;
    }
  }

  List<double> spend = [];
  List<String> item = [];
  itemSpend.forEach((key, value) {
    spend.add(value);
    item.add(key);
  });
  print('hello');
  var sortedKeys = itemSpend.keys.toList(growable: false)
    ..sort((k2, k1) => itemSpend[k1].compareTo(itemSpend[k2]));
  LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
      key: (k) => k, value: (k) => itemSpend[k]);

  sortedMap.forEach((key, value) {
    int newValue = value.round();
    TopItems holder = TopItems(key, newValue);
    temp.add(holder);
  });

  print(temp);

  List<TopItems> top2 = [];

  for (int i = 0; i < 2; i++) {
    top2.add(temp[i]);
  }

  return top2;
}

class MonthSpend {
  final DateTime month;
  final int spend;

  MonthSpend(this.month, this.spend);
}

List<MonthSpend> monthlySpendData(List<DataPoint> data) {
  List<MonthSpend> result = [];
  Map<DateTime, int> months = {
    DateFormat('MMM').parse('Jan'): 0,
    DateFormat('MMM').parse('Feb'): 0,
    DateFormat('MMM').parse('Mar'): 0,
    DateFormat('MMM').parse('Apr'): 0,
    DateFormat('MMM').parse('May'): 0,
    DateFormat('MMM').parse('Jun'): 0,
    DateFormat('MMM').parse('Jul'): 0,
    DateFormat('MMM').parse('Aug'): 0,
    DateFormat('MMM').parse('Sep'): 0,
    DateFormat('MMM').parse('Oct'): 0,
    DateFormat('MMM').parse('Nov'): 0,
    DateFormat('MMM').parse('Dec'): 0
  };

  for (int i = 0; i < data.length; i++) {
    var date = new DateFormat("yyyy-MM-dd").parse(data[i].date);
    print(date);
    var formatter = new DateFormat('MMM');
    var formatted = formatter.format(date);
    double spend = double.parse(data[i].total);
    months[DateFormat('MMM').parse(formatted)] = months[DateFormat('MMM').parse(formatted)] + spend.round();
    
  }

  months.forEach((key, value) {
    MonthSpend temp = MonthSpend(key, value);
    print(temp);
    result.add(temp);
  });
  return result;
}
