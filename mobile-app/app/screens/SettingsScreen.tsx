import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, Switch, TouchableOpacity, Alert } from 'react-native';
import { useDispatch, useSelector } from 'react-redux';
import { RootState } from '../store/store';
import { updateSettings } from '../store/appSlice';
import Header from '../components/Header';
import Colors from '../theme/colors';

const SettingsScreen: React.FC<{ navigation: any }> = ({ navigation }) => {
  const dispatch = useDispatch();
  const { settings } = useSelector((state: RootState) => state.app);

  const [notifications, setNotifications] = useState(settings.notifications);
  const [biometrics, setBiometrics] = useState(false);

  const handleToggle = (key: string, value: boolean) => {
    dispatch(updateSettings({ [key]: value }));
  };

  const SETTING_ROWS = [
    {
      group: 'Notifications',
      items: [
        { key: 'notifications', label: 'Push Notifications', value: notifications, onChange: (v: boolean) => { setNotifications(v); handleToggle('notifications', v); } },
      ],
    },
    {
      group: 'Security',
      items: [
        { key: 'biometrics', label: 'Biometric Login', value: biometrics, onChange: (v: boolean) => setBiometrics(v) },
      ],
    },
  ];

  return (
    <View style={styles.container}>
      <Header title="Settings" showBack onBack={() => navigation.goBack()} />
      <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
        {SETTING_ROWS.map((group) => (
          <View key={group.group} style={styles.group}>
            <Text style={styles.groupLabel}>{group.group.toUpperCase()}</Text>
            <View style={styles.groupCard}>
              {group.items.map((item, idx) => (
                <View key={item.key} style={[styles.row, idx < group.items.length - 1 && styles.rowBorder]}>
                  <Text style={styles.rowLabel}>{item.label}</Text>
                  <Switch
                    value={item.value}
                    onValueChange={item.onChange}
                    trackColor={{ false: Colors.border, true: Colors.accent }}
                    thumbColor={item.value ? Colors.bgPrimary : Colors.textDim}
                  />
                </View>
              ))}
            </View>
          </View>
        ))}

        <View style={styles.group}>
          <Text style={styles.groupLabel}>SUPPORT</Text>
          <View style={styles.groupCard}>
            {[
              { label: 'Privacy Policy', onPress: () => Alert.alert('Privacy Policy', 'This app collects minimal data to operate. See our full privacy policy at starmotor.com/privacy.') },
              { label: 'Terms of Service', onPress: () => Alert.alert('Terms of Service', 'By using this app you agree to our terms. See starmotor.com/terms.') },
              { label: 'App Version', onPress: () => {} },
            ].map((item, idx, arr) => (
              <TouchableOpacity key={item.label} style={[styles.row, styles.rowTouchable, idx < arr.length - 1 && styles.rowBorder]} onPress={item.onPress}>
                <Text style={styles.rowLabel}>{item.label}</Text>
                {item.label === 'App Version'
                  ? <Text style={styles.rowValue}>1.0.0</Text>
                  : <Text style={styles.rowArrow}>›</Text>}
              </TouchableOpacity>
            ))}
          </View>
        </View>
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: Colors.bgPrimary },
  content: { padding: 16, paddingBottom: 40 },
  group: { marginBottom: 24 },
  groupLabel: { color: Colors.textDim, fontSize: 10, fontWeight: '600', letterSpacing: 1.5, marginBottom: 8, paddingLeft: 4 },
  groupCard: { backgroundColor: Colors.bgCard, borderRadius: 8, borderWidth: 1, borderColor: Colors.border, overflow: 'hidden' },
  row: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', paddingHorizontal: 16, paddingVertical: 13 },
  rowTouchable: {},
  rowBorder: { borderBottomWidth: 1, borderBottomColor: Colors.borderDark },
  rowLabel: { color: Colors.textPrimary, fontSize: 14, fontWeight: '400' },
  rowValue: { color: Colors.textSecondary, fontSize: 13 },
  rowArrow: { color: Colors.accentDim, fontSize: 20, fontWeight: '300' },
});

export default SettingsScreen;
