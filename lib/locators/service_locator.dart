import 'package:get_it/get_it.dart';
import 'package:newsapp/repository/news_store.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NewsStore>(() => NewsStore());
}
