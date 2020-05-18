import 'package:ProcureCentre/dashboard/helper/data_transformer.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

List<charts.Series<TopSuppliers, String>> createSupplierData(List<DataPoint> initalData) {
  List<TopSuppliers> data = topSupplierData(initalData);
  return [
    new charts.Series<TopSuppliers, String>(
      id: 'Suppliers',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (TopSuppliers sales, _) => sales.name,
      measureFn: (TopSuppliers sales, _) => int.parse(sales.spend.toString()),
      data: data,
    )
  ];
}

  List<charts.Series<CategorySpend, String>> createCategoryData(List<DataPoint> initialData) {
    List<CategorySpend> data = spendByCategory(initialData);
    var spend = 0;
    data.forEach((element) { spend = spend + element.spend;});
    return [
      new charts.Series<CategorySpend, String>(
        id: 'Categories',
        domainFn: (CategorySpend sales, _) => sales.category,
        measureFn: (CategorySpend sales, _) => sales.spend,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (CategorySpend row, _) => '${((row.spend /spend ) * 100).round()}%',
      )
    ];
  }

   List<charts.Series<LocationSpend, String>> createLocationData(List<DataPoint> initialData) {
         List<LocationSpend> data = spendByLocation(initialData);
    var spend = 0;
    data.forEach((element) { spend = spend + element.spend;});

    return [
      new charts.Series<LocationSpend, String>(
        id: 'Locations',
        domainFn: (LocationSpend sales, _) => sales.location,
        measureFn: (LocationSpend sales, _) => sales.spend,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LocationSpend row, _) => '${((row.spend /spend ) * 100).round()}%',
      )
    ];
  
}

   List<charts.Series<TopItems, String>> createItemData(List<DataPoint> initialData) {
         List<TopItems> data = topItemsData(initialData);

    return [
      new charts.Series<TopItems, String>(
        id: 'Items',
        domainFn: (TopItems sales, _) => sales.itemDescription,
        measureFn: (TopItems sales, _) => sales.spend,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (TopItems row, _) => '${row.itemDescription}: ${row.spend}',
      )
    ];
  
}

 List<charts.Series<MonthSpend, DateTime>> createMonthlyData(List<DataPoint> initialData) {
         List<MonthSpend> data = monthlySpendData(initialData);

    return [
      new charts.Series<MonthSpend, DateTime>(
        id: 'Months',
        domainFn: (MonthSpend sales, _) => sales.month,
        measureFn: (MonthSpend sales, _) => sales.spend,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (MonthSpend row, _) => '${row.month}: ${row.spend}',
      )
    ];
  
}