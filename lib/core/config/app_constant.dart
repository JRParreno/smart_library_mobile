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

  // static const clientId = 'RdDzD1LnFOltM34KjhSeJbPWbEYNw3VapkLjiTv2';
  // static const clientSecret =
  //     'Vlf9WqEYICJfsre5v9TtowQYC3RQRiL9r0QuZXGJlTWerCw9XQ9tPB5DCb57d8DYUPOx5ImGToDNJpdPzmJHsvPu23T7OlbEY4V4NqiKclLWgpV1Kebo9GJif5SQuVHw';
  // static const serverUrl = 'http://127.0.0.1:8000';

  static const clientId = 'o46wPJBYRnLUNa44Qa3YxTmglbI44qM0K2R9cxAe';

  static const clientSecret =
      'OLGh26iK8sybCiM10WukM8DnbFPWZy1WUJZgJmIrtsDtPrTgyAayvGCPIkEgWo81cpozIEY8AVDGP6nnPzQ0s5Ml7UlFUWuwJY7R3s33mADslisAZuLx5ipUgXCUwpSx';

  static const serverUrl = 'https://smart-library-core.onrender.com';

  static const apiUrl = '$serverUrl/api';
  static const apiUser = '$serverUrl/user';
}
