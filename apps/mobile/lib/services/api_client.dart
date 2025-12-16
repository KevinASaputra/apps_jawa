import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';
import 'package:built_value/serializer.dart';
import 'auth_service.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;
  late Serializers _serializers;

  // API instances
  late AuthApi authApi;
  late ProfileApi profileApi;
  late ProductsApi productsApi;
  late BuyerApi buyerApi;
  late SellerApi sellerApi;
  late ActivitiesApi activitiesApi;
  late FinanceApi financeApi;
  late DashboardApi dashboardApi;
  late AdminApi adminApi;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _initialize();
  }

  void _initialize() {
    // Initialize Dio with base configuration
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://apps-jawa-backend.vercel.app',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for logging and auth
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
      ),
    );

    // Add auth interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await AuthService().getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Token expired or invalid
            await AuthService().clearAuth();
          }
          return handler.next(error);
        },
      ),
    );

    // Initialize serializers
    _serializers = standardSerializers;

    // Initialize API instances
    authApi = AuthApi(_dio, _serializers);
    profileApi = ProfileApi(_dio, _serializers);
    productsApi = ProductsApi(_dio, _serializers);
    buyerApi = BuyerApi(_dio, _serializers);
    sellerApi = SellerApi(_dio, _serializers);
    activitiesApi = ActivitiesApi(_dio, _serializers);
    financeApi = FinanceApi(_dio, _serializers);
    dashboardApi = DashboardApi(_dio, _serializers);
    adminApi = AdminApi(_dio, _serializers);
  }

  // Getter for dio instance if needed for custom requests
  Dio get dio => _dio;

  // Method to update base URL if needed
  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }
}
