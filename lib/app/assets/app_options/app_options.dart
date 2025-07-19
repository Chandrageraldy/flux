import 'package:flux/app/viewmodels/app_config_vm/locale_view_model.dart';
import 'package:flux/app/viewmodels/app_config_vm/theme_view_model.dart';
import 'package:flux/app/viewmodels/base_view_model.dart';
import 'package:flux/app/viewmodels/user_vm/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// Configure Supabase URL and Key
const SUPABASE_URL = 'https://boatxsvwhwnhmbmuiesv.supabase.co';
const SUPABASE_KEY =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvYXR4c3Z3aHduaG1ibXVpZXN2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI4NjQ4OTAsImV4cCI6MjA2ODQ0MDg5MH0.shQgX4f_exgE54cK8h8nCIvIIbe2AurGa6T8Nnt_IXM';

List<SingleChildWidget> providerAssets() => [
      ChangeNotifierProvider(create: (_) => BaseViewModel()),
      ChangeNotifierProvider(create: (_) => LocaleViewModel()),
      ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ChangeNotifierProvider(create: (_) => UserViewModel()),
    ];
