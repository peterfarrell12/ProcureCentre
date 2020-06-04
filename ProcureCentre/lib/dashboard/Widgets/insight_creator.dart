import 'package:ProcureCentre/dashboard/helper/data_transformer.dart';
import 'package:ProcureCentre/extraction/models/extracted_data.dart';
import 'dart:math';

Random random = new Random();

String createInsight(int caseNumber, List<DataPoint> data) {
  print("Maybeeeee");
  switch (caseNumber) {
    case 1:
      {
        print('case 1');
        var txt = _insight1(data);
        print(txt);
        return txt;
      }
    case 2:
      {
                var txt = _insight2(data);
                        print(txt);

        return txt;
      }
    case 3:
      {
                var txt = _insight3(data);
                        print(txt);

        return txt;
      }
    case 4:
      {
                var txt = _insight4(data);
                        print(txt);

        return txt;
      }
    case 5:
      {
                var txt = _insight5(data);
                        print(txt);

        return txt;
      }
    case 6:
      {
                var txt = _insight6(data);
                        print(txt);

        return txt;
      }
    case 7:
      {
                var txt = _insight7(data);
                        print(txt);

        return txt;
      }

      break;
    default:
      return "There was an issue please try again!";
  }
}

//Top Supplier Spend Percentage
String _insight1(List<DataPoint> data) {
  var tp = topSupplierData(data);
  var topSupplier = tp[0];
  var spend = totalSpend(data);

  var supplierSpend = (topSupplier.spend / spend) * 100;
  var sP = supplierSpend.round();

  return '$sP% of this spend is with ${topSupplier.name}';
}


//Large Invoice
_insight2(List<DataPoint> data) {
  var avgInvoice = avgPerInvoice(data);
  print(avgInvoice);
  int multiplier = random.nextInt(5) + 3;
  for (int i = 0; i < data.length; i++) {
    if ((double.parse(data[i].total) > (avgInvoice * multiplier))) {
      return  'Invoice ${data[i].invoice} is over $multiplier times as large as the average rate per invoice';
    } else {
      int newInsight = random.nextInt(6);
      createInsight(newInsight, data);
    }
  }

  
}

//Random Category Breakdown
String _insight3(List<DataPoint> data) {
  var cats = categories(data);
  int catPicker = random.nextInt(cats.length);
  var chosenCat = cats[catPicker];

  var filteredList = data.where((f) => f.category == chosenCat).toList();
  var suppliers = totalSuppliers(filteredList);
  var topSupplier = topSupplierData(filteredList)[0];
  var spend = totalSpend(filteredList);
  var supplierSpend = ((topSupplier.spend / spend) * 100).round();


  return "In The $chosenCat Category, there are $suppliers suppliers, with ${topSupplier.name} accounting for $supplierSpend% of the Spend";

}

//Average Spend Per Month
String _insight4(data) {

  var monthly = monthlySpendData(data);
  var total = 0;
  monthly.forEach((element) {total = total + element.spend;});
  var average = (total/12).round();
  return "The average monthly spend is €$average";
}

//Average Spend In A Category
String _insight5(data) {
    var cats = categories(data);
  int catPicker = random.nextInt(cats.length);
  var chosenCat = cats[catPicker];
  var filteredList = data.where((f) => f.category == chosenCat).toList();

    var monthly = monthlySpendData(filteredList);
  var total = 0;
  monthly.forEach((element) {total = total + element.spend;});
  var average = (total/12).round();
  return "The average monthly spend in $chosenCat is €$average";

}

String _insight6(data) {
        var monthly = monthlySpendData(data);
        var q1 = 0;
        var q2 = 0;
        var q3 = 0;
        var q4 = 0;

        for (int i =0; i< monthly.length; i++) {
          print(monthly[i].month);
          if (monthly[i].month.toString() == "Jan" || monthly[i].month.toString() == "Feb"  || monthly[i].month.toString() == "Mar" ){
            q1 = q1 + monthly[i].spend;
          }
          else if (monthly[i].month.toString() == "Apr" || monthly[i].month.toString() == "May"  || monthly[i].month.toString() == "Jun" ) {
            q2 = q2 + monthly[i].spend;
          }
                    else if (monthly[i].month.toString() == "Jul" || monthly[i].month.toString() == "Aug"  || monthly[i].month.toString() == "Sep" ) {
            q3 = q3 + monthly[i].spend;
          }
                    else if (monthly[i].month.toString() == "Oct" || monthly[i].month.toString() == "Nov"  || monthly[i].month.toString() == "Dec" ) {
            q4 = q4 + monthly[i].spend;
          }

        }

        return ("Quarter 1 Spend: €${q1.round()}, \n Quarter 2 Spend: €${q2.round()},\n Quarter 3 Spend: €${q3.round()},\n Quarter 4 Spend: €${q4.round()}");


}

String _insight7(data) {
    return "Insight 7";

}
