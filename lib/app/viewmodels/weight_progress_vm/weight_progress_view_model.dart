import 'package:flux/app/models/weight_log_model/weight_log_model.dart';
import 'package:flux/app/repositories/plan_repo/plan_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class WeightProgressViewModel extends BaseViewModel {
  PlanRepository planRepository = PlanRepository();

  List<WeightLogModel> weightLogs = [];
  List<WeightLogModel> allWeightLogs = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getWeightLogs() async {
    _isLoading = true;
    notifyListeners();

    final response = await planRepository.getWeightLogs();
    checkError(response);
    final responseData = response.data as List<WeightLogModel>;
    weightLogs = responseData.reversed.toList();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getAllWeightLogs() async {
    _isLoading = true;
    notifyListeners();

    final response = await planRepository.getAllWeightLogs();
    checkError(response);
    final responseData = response.data as List<WeightLogModel>;
    allWeightLogs = responseData.reversed.toList();
    _isLoading = false;
    notifyListeners();
  }
}
