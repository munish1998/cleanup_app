import 'package:cleanup_mobile/Providers/homeProvider.dart';
import 'package:cleanup_mobile/Providers/profileProivder.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'authProvider.dart';

class AllProviders {
  List<SingleChildWidget> allProvider = [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => TaskProviders()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
  ];
}
