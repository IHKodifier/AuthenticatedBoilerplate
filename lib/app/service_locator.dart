import 'package:get_it/get_it.dart';
import '../services/dialog_service.dart';
import '../services/authentication_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';

final GetIt serviceLocator = GetIt.instance;

void registerAllServicesWithLocator() {
  // TODO:  register all services here as [preferabbly lazy] singletons
  serviceLocator.registerLazySingleton(() => NavigationService());
  serviceLocator.registerLazySingleton(() => DialogService());
  serviceLocator.registerLazySingleton(() => AuthenticationService());
  serviceLocator.registerLazySingleton(() => FirestoreService());
}
