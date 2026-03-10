class AppValidators {
  AppValidators._();

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入手机号';
    }
    final phoneRegex = RegExp(r'^1[3-9]\d{9}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return '请输入有效的手机号';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入邮箱';
    }
    final emailRegex = RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return '请输入有效的邮箱地址';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入密码';
    }
    if (value.length < 8) {
      return '密码至少需要8个字符';
    }
    if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
      return '密码需要包含至少一个字母';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return '密码需要包含至少一个数字';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return '请确认密码';
    }
    if (value != password) {
      return '两次输入的密码不一致';
    }
    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入验证码';
    }
    if (value.length != 6 || !RegExp(r'^\d{6}$').hasMatch(value)) {
      return '请输入6位数字验证码';
    }
    return null;
  }

  static String? nickname(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入昵称';
    }
    if (value.trim().length < 2) {
      return '昵称至少需要2个字符';
    }
    if (value.trim().length > 20) {
      return '昵称不能超过20个字符';
    }
    return null;
  }

  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? '此项'}不能为空';
    }
    return null;
  }

  static String? postalCode(String? value) {
    if (value == null || value.isEmpty) return null; // optional
    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return '请输入有效的邮政编码（6位数字）';
    }
    return null;
  }

  static String? minLength(String? value, int min, [String? fieldName]) {
    if (value == null || value.isEmpty) return '${fieldName ?? '此项'}不能为空';
    if (value.length < min) return '${fieldName ?? '内容'}至少需要$min个字符';
    return null;
  }

  static String? maxLength(String? value, int max, [String? fieldName]) {
    if (value != null && value.length > max) {
      return '${fieldName ?? '内容'}不能超过$max个字符';
    }
    return null;
  }
}
