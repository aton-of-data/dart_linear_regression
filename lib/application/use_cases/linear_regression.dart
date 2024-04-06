// application/use_cases/linear_regression_use_case.dart
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';

class LinearRegressionUseCase {
  final LinearRegressor _model;
  final arbitraryNumber = 40;

  LinearRegressionUseCase(this._model);

  double calculateMAPE(Iterable<dynamic> actual, Iterable<dynamic> predicted) {
    final errors = <double>[];

    for (var i = 0; i < actual.length; i++) {
      final error =
          (actual.elementAt(i) - predicted.elementAt(i)) / actual.elementAt(i);

      errors.add(error.abs());
    }

    final meanAbsolutePercentageError =
        errors.reduce((a, b) => a + b) / errors.length;

    return meanAbsolutePercentageError;
  }

  Iterable<dynamic> getPredictedValues(DataFrame unlabelledData) {
    final prediction = _model.predict(unlabelledData);
    return prediction['quality'].data.skip(arbitraryNumber).take(5).toList();
  }

  Iterable<dynamic> getActualValues(DataFrame testData) {
    return testData['quality'].data.skip(arbitraryNumber).take(5).toList();
  }
}
