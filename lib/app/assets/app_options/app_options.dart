import 'package:flux/app/viewmodels/app_config_vm/locale_view_model.dart';
import 'package:flux/app/viewmodels/app_config_vm/theme_view_model.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';
import 'package:flux/app/viewmodels/plan_vm/plan_view_model.dart';
import 'package:flux/app/viewmodels/user_vm/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providerAssets() => [
      ChangeNotifierProvider(create: (_) => BaseViewModel()),
      ChangeNotifierProvider(create: (_) => LocaleViewModel()),
      ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ChangeNotifierProvider(create: (_) => UserViewModel()),
      ChangeNotifierProvider(create: (_) => PlanViewModel()),
    ];
