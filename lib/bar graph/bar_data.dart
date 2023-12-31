import 'package:expense/bar%20graph/individual_bar.dart';
import 'package:fl_chart/src/chart/bar_chart/bar_chart_data.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });
  List<IndividualBar> barData = [];
  //initailize bar data
  void initailizeBarData() {
    barData = [
      //sun
      IndividualBar(x: 0, y: sunAmount),
      //mon
      IndividualBar(x: 1, y: monAmount),
      //tue
      IndividualBar(x: 2, y: tueAmount),
      //wed
      IndividualBar(x: 3, y: wedAmount),
      //thur
      IndividualBar(x: 4, y: thurAmount),
      //fri
      IndividualBar(x: 5, y: friAmount),
      //sat
      IndividualBar(x: 6, y: satAmount),
    ];
  }

  map(BarChartGroupData Function(dynamic data) param0) {}
}
