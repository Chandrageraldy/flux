import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class ChiaChatbotPage extends BaseStatefulPage {
  const ChiaChatbotPage({super.key});

  @override
  State<ChiaChatbotPage> createState() => _ChiaChatbotPageState();
}

class _ChiaChatbotPageState extends BaseStatefulState<ChiaChatbotPage> {
  @override
  Widget body() {
    return const Center(
      child: Text('ChiaChatbotPage body'),
    );
  }
}
