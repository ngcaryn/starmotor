import 'package:flutter_test/flutter_test.dart';
import 'package:starmotor/utils/validators.dart';

void main() {
  group('AppValidators', () {
    group('phone', () {
      test('valid CN phone number passes', () {
        expect(AppValidators.phone('13812345678'), isNull);
        expect(AppValidators.phone('18900000000'), isNull);
      });

      test('empty phone fails', () {
        expect(AppValidators.phone(''), isNotNull);
        expect(AppValidators.phone(null), isNotNull);
      });

      test('invalid phone fails', () {
        expect(AppValidators.phone('12345'), isNotNull);
        expect(AppValidators.phone('10000000000'), isNotNull);
      });
    });

    group('email', () {
      test('valid email passes', () {
        expect(AppValidators.email('user@example.com'), isNull);
        expect(AppValidators.email('user.name+tag@domain.co'), isNull);
      });

      test('invalid email fails', () {
        expect(AppValidators.email('notanemail'), isNotNull);
        expect(AppValidators.email(''), isNotNull);
        expect(AppValidators.email(null), isNotNull);
      });
    });

    group('password', () {
      test('valid password passes', () {
        expect(AppValidators.password('abcd1234'), isNull);
        expect(AppValidators.password('MyPass99'), isNull);
      });

      test('too short fails', () {
        expect(AppValidators.password('ab12'), isNotNull);
      });

      test('no letters fails', () {
        expect(AppValidators.password('12345678'), isNotNull);
      });

      test('no digits fails', () {
        expect(AppValidators.password('abcdefgh'), isNotNull);
      });
    });

    group('otp', () {
      test('valid 6-digit OTP passes', () {
        expect(AppValidators.otp('123456'), isNull);
      });

      test('invalid OTP fails', () {
        expect(AppValidators.otp('12345'), isNotNull);
        expect(AppValidators.otp('abcdef'), isNotNull);
        expect(AppValidators.otp(''), isNotNull);
      });
    });

    group('nickname', () {
      test('valid nickname passes', () {
        expect(AppValidators.nickname('车友'), isNull);
        expect(AppValidators.nickname('StarMotor用户'), isNull);
      });

      test('too short fails', () {
        expect(AppValidators.nickname('A'), isNotNull);
      });

      test('too long fails', () {
        expect(AppValidators.nickname('A' * 21), isNotNull);
      });
    });
  });
}
