import 'package:ProcureCentre/dashboard/helper/data_transformer.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'dart:math';

Random random = new Random();

createInsight(int caseNumber, List<DataPoint> data) {
  switch (caseNumber) {
    case 1:
      {
        return _insight1(data);
      }
    case 2:
      {
        return _insight2(data);
      }
    case 3:
      {
        return _insight3(data);
      }
    case 4:
      {
        return _insight4(data);
      }
    case 5:
      {
        return _insight5(data);
      }
    case 6:
      {
        return _insight6(data);
      }
    case 7:
      {
        return _insight7(data);
      }

      break;
    default:
      return "There was an issue please try again!";
  }
}

//Top Supplier Spend Percentage
_insight1(List<DataPoint> data) {
  var topSupplier = topSupplierData(data)[0];
  var spend = totalSpend(data);

  var supplierSpend = (topSupplier.spend / spend) * 100;

  return ('$supplierSpend% of this spend is with $topSupplier');
}


//Large Invoice
_insight2(List<DataPoint> data) {
  var avgInvoice = avgPerInvoice(data);
  int multiplier = random.nextInt(5) + 3;
  for (int i = 0; i < data.length; i++) {
    if ((double.parse(data[i].total) > (avgInvoice * multiplier))) {
      return ('Invoice ${data[i].invoice} is over $multiplier times as large as the average rate per invoice');
    } else {
      int newInsight = random.nextInt(6);
      createInsight(newInsight, data);
    }
  }
}

//Random Category Breakdown
_insight3(List<DataPoint> data) {
  var cats = categories(data);
  int catPicker = random.nextInt(cats.length);
  var chosenCat = cats[catPicker];

  var filteredList = data.where((f) => f.category == chosenCat).toList();
  var suppliers = totalSuppliers(filteredList);
  var topSupplier = topSupplierData(filteredList)[0];
  var spend = totalSpend(filteredList);
  var supplierSpend = (topSupplier.spend / spend) * 100;

  return ("In The $chosenCat Category, there are $suppliers Supplier, with $topSupplier accounting for $supplierSpend% of the Spend");

}

_insight4(data) {}

_insight5(data) {}

_insight6(data) {}

_insight7(data) {}
