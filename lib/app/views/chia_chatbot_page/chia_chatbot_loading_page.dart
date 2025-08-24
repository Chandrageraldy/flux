import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/viewmodels/chia_chatbot_vm/chia_chatbot_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class ChiaChatbotLoadingPage extends BaseStatefulPage {
  const ChiaChatbotLoadingPage({super.key});

  @override
  State<ChiaChatbotLoadingPage> createState() => _ChiaChatbotLoadingPageState();
}

class _ChiaChatbotLoadingPageState extends BaseStatefulState<ChiaChatbotLoadingPage> {
  @override
  PreferredSizeWidget? appbar() => DefaultAppBar();

  @override
  void initState() {
    _getLoggedFoods();
    super.initState();
  }

  @override
  Widget body() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(AnimationPath.starAIAnimation, width: AppStyles.kSize64, height: AppStyles.kSize64),
          AppStyles.kSizedBoxH20,
          Padding(
            padding: AppStyles.kPaddSH20,
            child: Text(
              '"One moment, Chia is gathering the facts..."',
              style: _Styles.getLoadingLabelTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _ChiaChatbotLoadingPageState {
  Future<void> _getLoggedFoods() async {
    final response = await tryCatch(context, () => context.read<ChiaChatbotViewModel>().getLoggedFoods());

    if (response == true && mounted) {
      context.router.replace(ChiaChatbotRoute());
    }
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Loading Label Text Style
  static TextStyle getLoadingLabelTextStyle() {
    return Quicksand.medium.withSize(FontSizes.medium);
  }
}
