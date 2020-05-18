
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';


class BarChart extends StatelessWidget {
   final List<charts.Series> seriesList;
  final bool animate;
  final String text;

  BarChart(this.seriesList, this.text,{this.animate});


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(

      seriesList,
      animate: animate,
      behaviors: [new charts.ChartTitle(text,
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start,
            innerPadding: 18,
            ),
  
            ],
            domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(

              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 8, // size in Pts.
                  color: charts.MaterialPalette.black),
          ))
    );
  }



}

class CategoryPieChart extends StatelessWidget {
   final List<charts.Series> seriesList;
  final bool animate;
  final String text;

  CategoryPieChart(this.seriesList,this.text, {this.animate});


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(

      seriesList,
      animate: animate,
        behaviors:             [new charts.DatumLegend(
          // Positions for "start" and "end" will be left and right respectively
          // for widgets with a build context that has directionality ltr.
          // For rtl, "start" and "end" will be right and left respectively.
          // Since this example has directionality of ltr, the legend is
          // positioned on the right side of the chart.
          position: charts.BehaviorPosition.end,
          // By default, if the position of the chart is on the left or right of
          // the chart, [horizontalFirst] is set to false. This means that the
          // legend entries will grow as new rows first instead of a new column.
          horizontalFirst: false,
          // This defines the padding around each legend entry.
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          // Set [showMeasures] to true to display measures in series legend.
          //showMeasures: true,
          // Configure the measure value to be shown by default in the legend.
          //legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
          // Optionally provide a measure formatter to format the measure value.
          // If none is specified the value is formatted as a decimal.
          // measureFormatter: (num value) {
          //   return value == null ? '-' : '${value}k';
          // },
        ),
                new charts.ChartTitle(text,
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start,
            innerPadding: 18),],

      defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside)])
              );
    
  }



  }

  class DonutAutoLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final String text;

  DonutAutoLabelChart(this.seriesList, this.text,{this.animate});

  


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
    
        animate: animate,
                behaviors: [new charts.DatumLegend(
          // Positions for "start" and "end" will be left and right respectively
          // for widgets with a build context that has directionality ltr.
          // For rtl, "start" and "end" will be right and left respectively.
          // Since this example has directionality of ltr, the legend is
          // positioned on the right side of the chart.
          position: charts.BehaviorPosition.end,
          // By default, if the position of the chart is on the left or right of
          // the chart, [horizontalFirst] is set to false. This means that the
          // legend entries will grow as new rows first instead of a new column.
          horizontalFirst: false,
          // This defines the padding around each legend entry.
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          // Set [showMeasures] to true to display measures in series legend.
          //showMeasures: true,
          // Configure the measure value to be shown by default in the legend.
          //legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
          // Optionally provide a measure formatter to format the measure value.
          // If none is specified the value is formatted as a decimal.
          // measureFormatter: (num value) {
          //   return value == null ? '-' : '${value}k';
          // },
        ),
                new charts.ChartTitle(text,
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start,
            innerPadding: 18),],

        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]
            ));
  }
  }

  class HorizontalBarLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final String text;

  HorizontalBarLabelChart(this.seriesList, this.text,{this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
      behaviors: [new charts.ChartTitle(text,
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start,
            innerPadding: 18),],
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );
  }

  }




class PointsLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
    final String text;


  PointsLineChart(this.seriesList, this.text, {this.animate});


  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(seriesList,
        animate: animate,
      behaviors: [new charts.ChartTitle(text,
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start,
            innerPadding: 18),],
        primaryMeasureAxis: new charts.NumericAxisSpec(
            tickProviderSpec:
                new charts.BasicNumericTickProviderSpec(zeroBound: false)));
  
  }
}