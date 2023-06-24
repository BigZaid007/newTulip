class SendOTPRequest {
  final String phone;

  SendOTPRequest({required this.phone});

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
    };
  }
}
