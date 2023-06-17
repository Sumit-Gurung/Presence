import 'package:presence/graphs/barGraphs/individual_barGraph.dart';

class BarData {
  final double sunData;
  final double MonData;
  final double TueData;
  final double WedData;
  final double ThurData;
  final double FriData;
  final double SatData;

  BarData(this.sunData, this.MonData, this.TueData, this.WedData, this.ThurData,
      this.FriData, this.SatData);
  List<IndividualBar> barData = [];
  void initBar() {
    barData = [
      IndividualBar(x: 1, y: sunData),
      IndividualBar(x: 2, y: MonData),
      IndividualBar(x: 3, y: TueData),
      IndividualBar(x: 4, y: WedData),
      IndividualBar(x: 5, y: ThurData),
      IndividualBar(x: 6, y: FriData),
      IndividualBar(x: 7, y: SatData),
    ];
  }
}
