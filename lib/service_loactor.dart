import 'package:get_it/get_it.dart';

import 'manager/base_info_manager.dart';

GetIt sl = GetIt.instance;

void setUpServiceLocator(){
  // base state for the app layout
  sl.registerLazySingleton<BaseInfomanager>(()=>BaseInfoManagerImpl());
}