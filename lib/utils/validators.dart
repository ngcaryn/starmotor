class AppValidators {
  AppValidators._();

  /// Chinese mobile phone number (11 digits, starts with 1)
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return '请输入手机号';
    final re = RegExp(r'^1[3-9]\d{9}$');
    if (!re.hasMatch(value)) return '请输入有效的手机号';
    return null;
  }

  /// Email address
  static String? email(String? value) {
    if (value == null || value.isEmpty) return '请输入邮箱地址';
    final re = RegExp(r'^[\w.+-]+@[\w-]+\.[a-z]{2,}$',
        caseSensitive: false);
    if (!re.hasMatch(value)) return '请输入有效的邮箱地址';
    return null;
  }

  /// Password: at least 8 chars, contains letter and digit
  static String? password(String? value) {
    if (value == null || value.isEmpty) return '请输入密码';
    if (value.length < 8) return '密码长度至少8位';
    if (!value.contains(RegExp(r'[a-zA-Z]'))) return '密码需包含字母';
    if (!value.contains(RegExp(r'\d'))) return '密码需包含数字';
    return null;
  }

  /// 6-digit OTP
  static String? otp(String? value) {
    if (value == null || value.isEmpty) return '请输入验证码';
    if (!RegExp(r'^\d{6}$').hasMatch(value)) return '请输入6位验证码';
    return null;
  }

  /// Nickname: 2-20 chars
  static String? nickname(String? value) {
    if (value == null || value.isEmpty) return '请输入昵称';
    if (value.length < 2) return '昵称至少2个字符';
    if (value.length > 20) return '昵称最多20个字符';
    return null;
  }
}
