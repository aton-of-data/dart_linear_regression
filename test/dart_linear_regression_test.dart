import 'package:dart_linear_regression/application/use_cases/linear_regression.dart';
import 'package:dart_linear_regression/infrastructure/repositories/wine_quality.dart';
import 'package:test/test.dart';
import 'package:ml_algo/ml_algo.dart';

void main() {
  test('MAPE calculation', () {
    final repository = WineQualityRepository();
    final splits = repository.getDataSplits(0.7);
    final testData = splits.last;

    final model = LinearRegressor(testData, 'quality');
    final unlabelledData = testData.dropSeries(names: ['quality']);

    final useCase = LinearRegressionUseCase(model);

    final predictedValues = useCase.getPredictedValues(unlabelledData);
    final actualValues = useCase.getActualValues(testData);

    final mape = calculateMAPE(actualValues, predictedValues);

    final tolerance = 0.1; // 10% tolerance
    final expectedMapeValue = 0.5; // 5% expected MAPE

    expect(
      mape,
      lessThanOrEqualTo(expectedMapeValue + tolerance),
    );
  });
}

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
