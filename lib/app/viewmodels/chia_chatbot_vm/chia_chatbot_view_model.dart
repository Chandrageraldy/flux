import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/chat_message_model/chat_message_model.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/models/plan_model.dart/plan_model.dart';
import 'package:flux/app/models/user_profile_model/user_profile_model.dart';
import 'package:flux/app/repositories/chatbot_repo/chatbot_repository.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';

class ChiaChatbotViewModel extends BaseViewModel {
  ChatbotRepository chatbotRepository = ChatbotRepository();
  FoodRepository foodRepository = FoodRepository();

  List<ChatMessageModel> chatMessages = [
    ChatMessageModel(
      text: "Hello! I'm Chia, your personal nutrition assistant. How can I help you today?",
      isUser: false,
    ),
  ];

  PlanModel? userPlan = SharedPreferenceHandler().getPlan();
  UserProfileModel? userProfile = SharedPreferenceHandler().getUser();

  List<LoggedFoodModel> loggedFoodsList = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> sendMessage({required String userMessage}) async {
    final userInformation =
        'Profile Info: ${userProfile?.toJson()}, Plan Info: ${userPlan?.toJson()}, Logged Foods: ${loggedFoodsList.map((food) => food.toJson()).toList()}';

    chatMessages = [
      ...chatMessages,
      ChatMessageModel(text: userMessage, isUser: true),
    ];
    notifyListeners();

    _isLoading = true;
    notifyListeners();

    final response = await chatbotRepository.sendMessage(userMessage: userMessage, userInformation: userInformation);

    checkError(response);

    _isLoading = false;

    chatMessages = [
      ...chatMessages,
      ChatMessageModel(text: response.data, isUser: false, isTypedComplete: false),
    ];

    notifyListeners();
  }

  Future<bool> getLoggedFoods() async {
    final response = await foodRepository.getLoggedFoods(selectedDate: DateTime.now());
    checkError(response);
    loggedFoodsList = response.data as List<LoggedFoodModel>;
    notifyListeners();

    return response.status == ResponseStatus.COMPLETE;
  }

  void changeIsTypedComplete({required int index, required bool isTypedComplete}) {
    if (index < chatMessages.length) {
      chatMessages[index].isTypedComplete = isTypedComplete;
      notifyListeners();
    }
  }
}
