import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/viewmodels/chia_chatbot_vm/chia_chatbot_view_model.dart';

@RoutePage()
class ChiaChatbotNavigatorPage extends StatelessWidget {
  const ChiaChatbotNavigatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChiaChatbotViewModel(),
      child: AutoRouter(),
    );
  }
}
