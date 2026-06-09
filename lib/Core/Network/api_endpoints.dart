class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'https://nayem5001.binarybards.online/api/v1';

  // Auth endpoints
  static const String register = '/users/';
  static const String login = '/auth/login';
  static const String verifyOtp = '/auth/verify-otp';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String changePassword = '/auth/change-password';

  // Home endpoints
  static const String homeContent = '/home/content';

  // My List endpoints
  static const String recentlyWatched = '/recently-watched';
  static const String myCollection = '/my-collection';
}
