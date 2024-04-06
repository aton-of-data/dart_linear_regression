import 'package:dart_linear_regression/application/use_cases/linear_regression.dart';
import 'package:dart_linear_regression/infrastructure/repositories/wine_quality.dart';
import 'package:ml_algo/ml_algo.dart';

class LinearRegressionRunner {
  void run() {
    // Access the dataset.
    final repository = WineQualityRepository();

    // Split the dataset into training and testing subsets with a 70-30 split ratio.
    final splits = repository.getDataSplits(0.3);

    // Extract the training and testing subsets.
    final trainData = splits.first;
    final testData = splits.last;
    final model = LinearRegressor(trainData, 'quality');

    // Prepare the testing data by removing the 'quality' column.
    final unlabelledData = testData.dropSeries(names: ['quality']);

    // Instantiate LinearRegressionUseCase with the trained model.
    final useCase = LinearRegressionUseCase(model);

    // Predict wine quality for the testing data.
    final predictedValues = useCase.getPredictedValues(unlabelledData);
    final actualValues = useCase.getActualValues(testData);

    // Calculate MAPE (Mean Absolute Percentage Error).
    final mape = useCase.calculateMAPE(actualValues, predictedValues);

    // Print results.
    print('Actual values: $actualValues');
    print('Predicted values: $predictedValues');
    print('MAPE: $mape%');
  }
}
