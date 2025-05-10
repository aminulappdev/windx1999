class Urls {
  static const String _baseUrl = 'http://172.252.13.74:8000/api/v1';
  // static const String _baseUrl = 'http://192.168.10.160:8000/api/v1';
  static const String socketUrl = 'http://192.168.10.144:4001/';
  static const String createUserUrl = '$_baseUrl/users/create';
  static const String otpVerifyUrl = '$_baseUrl/otp/verify-otp';
  static const String loginUrl = '$_baseUrl/auth/login';
  static const String forgotEmailUrl = '$_baseUrl/auth/forgot-password';
  static const String resetPasswordUrl = '$_baseUrl/auth/reset-password';
  static const String resendOtpUrl = '$_baseUrl/otp/resend-otp';
  static const String userUpdateProfileUrl = '$_baseUrl/users/update-my-profile';

  static String updateUserByUrl(
    String id,
  ) {
    return '$_baseUrl/users/update/$id';
  }
}
