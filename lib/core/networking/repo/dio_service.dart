import 'package:dio/dio.dart';

class DioService {
  // Private instances of Dio for different APIs
  static final Dio _aladhanDio = Dio(
    BaseOptions(
      baseUrl: 'https://api.aladhan.com/v1', // Aladhan API Base URL
    ),
  );

  static final Dio _islamHouseDio = Dio(
    BaseOptions(
      baseUrl: 'https://api3.islamhouse.com/v3/paV29H2gm56kvLPy', // Islam House API Base URL
    ),
  );

  static final Dio _alquranDio = Dio(
    BaseOptions(
      baseUrl: 'https://api.alquran.cloud/v1', // AlQuran API Base URL
    ),
  );

  // Public getters to access different Dio instances
  static Dio get aladhanDio => _aladhanDio;
  static Dio get islamHouseDio => _islamHouseDio;
  static Dio get alquranDio => _alquranDio;
}
