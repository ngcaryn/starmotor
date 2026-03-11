import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  TextInput,
  ScrollView,
  TouchableOpacity,
  KeyboardAvoidingView,
  Platform,
  Alert,
} from 'react-native';
import { useDispatch, useSelector } from 'react-redux';
import { loginStart, loginSuccess, loginFailure } from '../store/authSlice';
import { RootState } from '../store/store';
import Button from '../components/Button';
import Colors from '../theme/colors';
import { login } from '../services/authService';

const LoginScreen: React.FC = () => {
  const dispatch = useDispatch();
  const { loading, error } = useSelector((state: RootState) => state.auth);

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);

  const handleLogin = async () => {
    if (!email.trim() || !password.trim()) {
      Alert.alert('Validation Error', 'Please enter your email and password.');
      return;
    }

    dispatch(loginStart());
    try {
      const response = await login({ email: email.trim(), password });
      dispatch(loginSuccess({ user: response.user, token: response.token }));
    } catch (err: unknown) {
      const message =
        err instanceof Error ? err.message : 'Login failed. Please try again.';
      dispatch(loginFailure(message));
    }
  };

  return (
    <KeyboardAvoidingView
      style={styles.container}
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
    >
      <ScrollView
        contentContainerStyle={styles.scrollContent}
        keyboardShouldPersistTaps="handled"
        showsVerticalScrollIndicator={false}
      >
        {/* Brand mark */}
        <View style={styles.logoContainer}>
          <View style={styles.logoMark}>
            <Text style={styles.logoLetter}>S</Text>
          </View>
          <Text style={styles.brandName}>STARMOTOR</Text>
          <Text style={styles.tagline}>PRECISION · PERFORMANCE · FUTURE</Text>
        </View>

        {/* Login form */}
        <View style={styles.formContainer}>
          <Text style={styles.formTitle}>Sign In</Text>

          {/* Email field */}
          <View style={styles.inputGroup}>
            <Text style={styles.label}>EMAIL</Text>
            <TextInput
              style={styles.input}
              value={email}
              onChangeText={setEmail}
              placeholder="your@email.com"
              placeholderTextColor={Colors.textDim}
              keyboardType="email-address"
              autoCapitalize="none"
              autoCorrect={false}
              editable={!loading}
            />
          </View>

          {/* Password field */}
          <View style={styles.inputGroup}>
            <Text style={styles.label}>PASSWORD</Text>
            <View style={styles.passwordRow}>
              <TextInput
                style={[styles.input, styles.passwordInput]}
                value={password}
                onChangeText={setPassword}
                placeholder="••••••••"
                placeholderTextColor={Colors.textDim}
                secureTextEntry={!showPassword}
                autoCapitalize="none"
                editable={!loading}
              />
              <TouchableOpacity
                onPress={() => setShowPassword(!showPassword)}
                style={styles.toggleButton}
                accessibilityLabel={showPassword ? 'Hide password' : 'Show password'}
              >
                <Text style={styles.toggleText}>
                  {showPassword ? 'Hide' : 'Show'}
                </Text>
              </TouchableOpacity>
            </View>
          </View>

          {/* Error message */}
          {error ? (
            <View style={styles.errorContainer}>
              <Text style={styles.errorText}>{error}</Text>
            </View>
          ) : null}

          {/* Forgot password */}
          <TouchableOpacity style={styles.forgotPassword}>
            <Text style={styles.forgotPasswordText}>Forgot Password?</Text>
          </TouchableOpacity>

          {/* Login button */}
          <Button
            title="Sign In"
            onPress={handleLogin}
            loading={loading}
            fullWidth
            size="large"
            style={styles.loginButton}
          />

          {/* Divider */}
          <View style={styles.divider}>
            <View style={styles.dividerLine} />
            <Text style={styles.dividerText}>OR</Text>
            <View style={styles.dividerLine} />
          </View>

          {/* Guest browse option */}
          <Button
            title="Browse as Guest"
            onPress={() => {}}
            variant="outline"
            fullWidth
            size="large"
          />
        </View>

        <Text style={styles.footerText}>
          New to StarMotor?{'  '}
          <Text style={styles.signUpLink}>Create Account</Text>
        </Text>
      </ScrollView>
    </KeyboardAvoidingView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Colors.bgPrimary,
  },
  scrollContent: {
    flexGrow: 1,
    paddingHorizontal: 24,
    paddingBottom: 40,
  },
  logoContainer: {
    alignItems: 'center',
    paddingTop: 80,
    paddingBottom: 40,
  },
  logoMark: {
    width: 72,
    height: 72,
    borderRadius: 36,
    backgroundColor: Colors.bgCard,
    borderWidth: 1,
    borderColor: Colors.border,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 20,
  },
  logoLetter: {
    color: Colors.accent,
    fontSize: 32,
    fontWeight: '200',
    letterSpacing: 2,
  },
  brandName: {
    color: Colors.textPrimary,
    fontSize: 22,
    fontWeight: '600',
    letterSpacing: 8,
    marginBottom: 8,
  },
  tagline: {
    color: Colors.textDim,
    fontSize: 10,
    letterSpacing: 2,
    fontWeight: '400',
  },
  formContainer: {
    backgroundColor: Colors.bgCard,
    borderRadius: 10,
    padding: 24,
    borderWidth: 1,
    borderColor: Colors.border,
  },
  formTitle: {
    color: Colors.textPrimary,
    fontSize: 20,
    fontWeight: '600',
    marginBottom: 24,
    letterSpacing: 0.5,
  },
  inputGroup: {
    marginBottom: 18,
  },
  label: {
    color: Colors.textDim,
    fontSize: 10,
    fontWeight: '600',
    marginBottom: 8,
    letterSpacing: 1.5,
  },
  input: {
    flex: 1,
    color: Colors.textPrimary,
    fontSize: 15,
    backgroundColor: Colors.bgInset,
    borderRadius: 6,
    borderWidth: 1,
    borderColor: Colors.border,
    paddingHorizontal: 14,
    paddingVertical: 13,
  },
  passwordRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  passwordInput: {
    flex: 1,
  },
  toggleButton: {
    paddingHorizontal: 12,
    paddingVertical: 13,
  },
  toggleText: {
    color: Colors.accentDim,
    fontSize: 13,
    fontWeight: '500',
  },
  errorContainer: {
    backgroundColor: 'rgba(184,64,64,0.08)',
    borderRadius: 6,
    borderWidth: 1,
    borderColor: 'rgba(184,64,64,0.25)',
    padding: 10,
    marginBottom: 12,
  },
  errorText: {
    color: Colors.danger,
    fontSize: 13,
  },
  forgotPassword: {
    alignSelf: 'flex-end',
    marginBottom: 20,
  },
  forgotPasswordText: {
    color: Colors.accentDim,
    fontSize: 13,
    fontWeight: '500',
  },
  loginButton: {
    marginBottom: 16,
  },
  divider: {
    flexDirection: 'row',
    alignItems: 'center',
    marginVertical: 16,
    gap: 12,
  },
  dividerLine: {
    flex: 1,
    height: 1,
    backgroundColor: Colors.border,
  },
  dividerText: {
    color: Colors.textDim,
    fontSize: 11,
    fontWeight: '500',
    letterSpacing: 1,
  },
  footerText: {
    color: Colors.textDim,
    fontSize: 14,
    textAlign: 'center',
    marginTop: 24,
  },
  signUpLink: {
    color: Colors.accent,
    fontWeight: '600',
  },
});

export default LoginScreen;
