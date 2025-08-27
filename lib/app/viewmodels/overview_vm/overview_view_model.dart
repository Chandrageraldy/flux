import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/active_user_pet_model/active_user_pet_model.dart';
import 'package:flux/app/models/daily_goals_model/daily_goals_model.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/models/response_model.dart';
import 'package:flux/app/models/user_energy_model/user_energy_model.dart';
import 'package:flux/app/models/weight_log_model/weight_log_model.dart';
import 'package:flux/app/repositories/daily_goals_repo/daily_goals_repository.dart';
import 'package:flux/app/repositories/energy_repo/energy_repository.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/repositories/pet_repo/pet_repository.dart';
import 'package:flux/app/repositories/plan_repo/plan_repository.dart';
import 'package:flux/app/repositories/user_repo/user_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class OverviewViewModel extends BaseViewModel {
  final PlanRepository planRepository = PlanRepository();
  final UserRepository userRepository = UserRepository();
  final PetRepository petRepository = PetRepository();
  final EnergyRepository energyRepository = EnergyRepository();
  final DailyGoalsRepository dailyGoalsRepository = DailyGoalsRepository();
  final FoodRepository foodRepository = FoodRepository();

  ActiveUserPetModel activeUserPet = ActiveUserPetModel();
  UserEnergyModel userEnergy = UserEnergyModel();
  List<LoggedFoodModel> loggedFoods = [];
  List<LoggedFoodModel> loggedFoodsBetweenDates = [];
  List<DailyGoalsModel> dailyGoals = [];
  List<WeightLogModel> weightLogs = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isUpdatingCurrentExp = false;
  bool get isUpdatingCurrentExp => _isUpdatingCurrentExp;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      final futures = [
        getPersonalizedPlan(),
        getUserProfile(),
        getActiveUserPet(),
        getUserEnergies(),
        getDailyGoals(),
        getLoggedFoodsBetweenDates(),
        getWeightLogs(),
      ];
      await Future.wait(futures);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getPersonalizedPlan() async {
    final response = await planRepository.getPersonalizedPlan();
    checkError(response);
  }

  Future<void> getUserProfile() async {
    final user = userRepository.sharedPreferenceHandler.getUser();
    final response = await userRepository.getUserProfile(userId: user?.userId ?? '');
    checkError(response);
  }

  Future<void> getActiveUserPet() async {
    final user = userRepository.sharedPreferenceHandler.getUser();
    final response = await petRepository.getActiveUserPet(userId: user?.userId ?? '');
    checkError(response);

    activeUserPet = response.data as ActiveUserPetModel;
    notifyListeners();
  }

  Future<void> updateCurrentExp({required int addedExp, required int energySpent}) async {
    _isUpdatingCurrentExp = true;
    notifyListeners();
    final user = userRepository.sharedPreferenceHandler.getUser();
    final currentExp = activeUserPet.currentExp ?? 0;
    final totalExp = currentExp + addedExp;
    final updateExpResponse = await petRepository.updateCurrentExp(userId: user?.userId ?? '', totalExp: totalExp);
    checkError(updateExpResponse);

    if (updateExpResponse.status == ResponseStatus.COMPLETE) {
      final currentEnergy = userEnergy.energies ?? 0;
      final totalEnergy = currentEnergy - energySpent;
      final updateEnergyResponse = await energyRepository.updateUserEnergies(
        userId: user?.userId ?? '',
        totalEnergy: totalEnergy,
      );
      userEnergy = updateEnergyResponse.data as UserEnergyModel;
      checkError(updateEnergyResponse);
    }

    activeUserPet = updateExpResponse.data as ActiveUserPetModel;
    _isUpdatingCurrentExp = false;
    notifyListeners();
  }

  Future<void> getUserEnergies() async {
    final user = userRepository.sharedPreferenceHandler.getUser();
    final response = await energyRepository.getUserEnergies(userId: user?.userId ?? '');
    checkError(response);
    userEnergy = response.data as UserEnergyModel;
    notifyListeners();
  }

  Future<void> getDailyGoals() async {
    final user = userRepository.sharedPreferenceHandler.getUser();

    final getTodayLoggedFoodsResponse = await foodRepository.getTodayLoggedFoods(selectedDate: DateTime.now());
    checkError(getTodayLoggedFoodsResponse);
    loggedFoods = getTodayLoggedFoodsResponse.data as List<LoggedFoodModel>;

    var totalCalories = 0;
    var totalProtein = 0;
    var totalMeals = 0;
    final mealTypes = <String>{};

    if (loggedFoods.isNotEmpty) {
      for (final food in loggedFoods) {
        totalCalories += food.calorieKcal?.toInt() ?? 0;
        totalProtein += food.proteinG?.toInt() ?? 0;

        if (food.mealType != null && food.mealType!.isNotEmpty) {
          mealTypes.add(food.mealType!);
        }
      }
      totalMeals = mealTypes.length;
    }

    if (getTodayLoggedFoodsResponse.status == ResponseStatus.COMPLETE) {
      final getDailyGoalsResponse = await dailyGoalsRepository.getDailyGoals(
          userId: user?.userId ?? '', totalCalories: totalCalories, totalProtein: totalProtein, totalMeals: totalMeals);
      checkError(getDailyGoalsResponse);
      dailyGoals = getDailyGoalsResponse.data as List<DailyGoalsModel>;
      notifyListeners();
    }
  }

  Future<void> claimReward({required int goalId, required int energyReward}) async {
    final user = userRepository.sharedPreferenceHandler.getUser();
    final claimRewardResponse = await dailyGoalsRepository.claimReward(userId: user?.userId ?? '', goalId: goalId);
    checkError(claimRewardResponse);
    final updatedGoal = claimRewardResponse.data as DailyGoalsModel;
    final index = dailyGoals.indexWhere((goal) => goal.id == updatedGoal.id);
    dailyGoals[index] = updatedGoal;
    notifyListeners();

    final totalEnergy = (userEnergy.energies ?? 0) + energyReward;
    final addEnergyResponse = await energyRepository.addUserEnergy(
      userId: user?.userId ?? '',
      totalEnergy: totalEnergy,
    );
    checkError(addEnergyResponse);
    final updatedEnergy = addEnergyResponse.data as UserEnergyModel;
    userEnergy = updatedEnergy;
    notifyListeners();
  }

  Future<void> getLoggedFoodsBetweenDates() async {
    final response = await foodRepository.getLoggedFoodsBetweenDates(
      startDate: DateTime.now().subtract(Duration(days: 6)),
      endDate: DateTime.now(),
    );
    checkError(response);
    loggedFoodsBetweenDates = response.data as List<LoggedFoodModel>;
    notifyListeners();
  }

  Future<void> getWeightLogs() async {
    final response = await planRepository.getWeightLogs();
    checkError(response);
    final responseData = response.data as List<WeightLogModel>;
    weightLogs = responseData.reversed.toList();
    notifyListeners();
  }
}
