import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';

class WineQualityRepository {
  DataFrame getDataFrame() {
    return getWineQualityDataFrame();
  }

  List<DataFrame> getDataSplits(double testFraction) {
    final data = getDataFrame();
    final splits = splitData(data, [1 - testFraction]);

    return splits;
  }
}
