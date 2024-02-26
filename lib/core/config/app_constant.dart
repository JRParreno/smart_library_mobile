import 'package:flutter/material.dart';

class AppConstant {
  static const kMockupHeight = 812;
  static const kMockupWidth = 375;
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );
  static const appName = 'Smart Library App';
  static const defaultPhoto =
      'https://t3.ftcdn.net/jpg/02/68/55/60/360_F_268556012_c1WBaKFN5rjRxR2eyV33znK4qnYeKZjm.jpg';

  static const clientId = '29vUuRG8nDoY6gADZqA0XUAjWr0uPHJuWt1bAEho';
  static const clientSecret =
      'qEK37y6ZmLssFCDBgLj7ESuA9FwhRdIOazHzr4Dm51cpOaOCZlKiGF2rHV2XgcSjkLuLKXitN2nrcTP3sFZ7qjzA7paDTLuCpvh2Mjg3FQe2yMN6k1PwxCtyRUcmEGwx';
  static const serverUrl = 'http://127.0.0.1:8000';

  // static const clientId = '9gw3LUTvRIFy3QWBnVf6pnIVQiuhECy3TIGICGjy';

  // static const clientSecret =
  //     'ZyqCGdPlPNyTxC3zDruFVv9O3Bhub77B1Gso5M5jcNUUjPuwwBzGU401c2fejF4nvAtcah6RZXC9JtKLOsPAzEN1Pwe7zqWs6vAHhFHlSP1KicX77FjnKjyNz0OYr0tj';

  // static const serverUrl = 'https://app-bin-core.onrender.com';

  static const apiUrl = '$serverUrl/api';
  static const apiUser = '$serverUrl/user';
}
