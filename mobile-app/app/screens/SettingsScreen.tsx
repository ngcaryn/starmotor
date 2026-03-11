import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  Switch,
  TouchableOpacity,
  Alert,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useDispatch, useSelector } from 'react-redux';
import { RootState } from '../store/store';
import { updateSettings } from '../store/appSlice';
import Header from '../components/Header';
import Card from '../components/Card';

const SettingsScreen: React.FC = () => {
  const dispatch = useDispatch();
  const { settings } = useSelector((state: RootState) => state.app);

  const toggleSetting = (key: keyof typeof settings, value: boolean) => {
    dispatch(updateSettings({ [key]: value }));
  };

  const LANGUAGE_OPTIONS = ['English', 'Chinese', 'Japanese', 'Korean'];
  const CURRENCY_OPTIONS = ['USD', 'CNY', 'EUR', 'GBP', 'JPY'];

  const handleSelectLanguage = () => {
    Alert.alert(
      'Select Language',
      '',
      LANGUAGE_OPTIONS.map((lang) => ({
        text: lang,
        onPress: () => dispatch(updateSettings({ language: lang.toLowerCase().substring(0, 2) })),
      }))
    );
  };

  const handleSelectCurrency = () => {
    Alert.alert(
      'Select Currency',
      '',
      CURRENCY_OPTIONS.map((currency) => ({
        text: currency,
        onPress: () => dispatch(updateSettings({ currency })),
      }))
    );
  };

  const SETTINGS_SECTIONS = [
    {
      title: 'Appearance',
      items: [
        {
          id: 'darkMode',
          icon: 'moon-outline',
          label: 'Dark Mode',
          type: 'toggle' as const,
          value: settings.darkMode,
          onToggle: (val: boolean) => toggleSetting('darkMode', val),
        },
      ],
    },
    {
      title: 'Notifications',
      items: [
        {
          id: 'notifications',
          icon: 'notifications-outline',
          label: 'Push Notifications',
          type: 'toggle' as const,
          value: settings.notifications,
          onToggle: (val: boolean) => toggleSetting('notifications', val),
        },
      ],
    },
    {
      title: 'Regional',
      items: [
        {
          id: 'language',
          icon: 'language-outline',
          label: 'Language',
          type: 'select' as const,
          value: settings.language.toUpperCase(),
          onPress: handleSelectLanguage,
        },
        {
          id: 'currency',
          icon: 'cash-outline',
          label: 'Currency',
          type: 'select' as const,
          value: settings.currency,
          onPress: handleSelectCurrency,
        },
      ],
    },
    {
      title: 'About',
      items: [
        {
          id: 'version',
          icon: 'information-circle-outline',
          label: 'App Version',
          type: 'info' as const,
          value: '1.0.0',
          onPress: undefined,
        },
        {
          id: 'changelog',
          icon: 'list-outline',
          label: 'What\'s New',
          type: 'nav' as const,
          onPress: () => Alert.alert('What\'s New', 'v1.0.0 - Initial release of StarMotor App'),
        },
        {
          id: 'feedback',
          icon: 'chatbox-ellipses-outline',
          label: 'Send Feedback',
          type: 'nav' as const,
          onPress: () => Alert.alert('Feedback', 'Thank you! Your feedback helps us improve.'),
        },
        {
          id: 'rate',
          icon: 'star-outline',
          label: 'Rate the App',
          type: 'nav' as const,
          onPress: () => Alert.alert('Rate Us', 'Redirecting to the app store...'),
        },
      ],
    },
  ];

  return (
    <View style={styles.container}>
      <Header title="Settings" />

      <ScrollView showsVerticalScrollIndicator={false} contentContainerStyle={styles.content}>
        {SETTINGS_SECTIONS.map((section) => (
          <View key={section.title} style={styles.section}>
            <Text style={styles.sectionTitle}>{section.title}</Text>
            <Card style={styles.sectionCard}>
              {section.items.map((item, index) => (
                <View key={item.id}>
                  <View
                    style={[
                      styles.settingRow,
                      index === section.items.length - 1 && styles.lastRow,
                    ]}
                  >
                    <View style={styles.settingLeft}>
                      <View style={styles.settingIcon}>
                        <Ionicons
                          name={item.icon as any}
                          size={18}
                          color="#00d4ff"
                        />
                      </View>
                      <Text style={styles.settingLabel}>{item.label}</Text>
                    </View>

                    {item.type === 'toggle' && (
                      <Switch
                        value={item.value as boolean}
                        onValueChange={item.onToggle}
                        trackColor={{ false: '#2a2a3e', true: '#007a99' }}
                        thumbColor={item.value ? '#00d4ff' : '#6a6a7a'}
                        ios_backgroundColor="#2a2a3e"
                      />
                    )}

                    {(item.type === 'select' || item.type === 'nav') && (
                      <TouchableOpacity
                        style={styles.settingRight}
                        onPress={item.onPress}
                        disabled={!item.onPress}
                      >
                        {'value' in item && item.value ? (
                          <Text style={styles.settingValue}>{item.value as string}</Text>
                        ) : null}
                        <Ionicons
                          name="chevron-forward"
                          size={16}
                          color="#4a4a5a"
                        />
                      </TouchableOpacity>
                    )}

                    {item.type === 'info' && (
                      <Text style={styles.settingValue}>{item.value as string}</Text>
                    )}
                  </View>
                  {index < section.items.length - 1 && (
                    <View style={styles.divider} />
                  )}
                </View>
              ))}
            </Card>
          </View>
        ))}

        <Text style={styles.footer}>
          © 2025 StarMotor Co., Ltd.{'\n'}All rights reserved.
        </Text>
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0a0a0f',
  },
  content: {
    padding: 16,
    paddingBottom: 32,
  },
  section: {
    marginBottom: 20,
  },
  sectionTitle: {
    color: '#6a6a7a',
    fontSize: 12,
    fontWeight: '700',
    letterSpacing: 1.5,
    textTransform: 'uppercase',
    marginBottom: 8,
    paddingLeft: 4,
  },
  sectionCard: {
    padding: 0,
    overflow: 'hidden',
  },
  settingRow: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    padding: 14,
    paddingHorizontal: 16,
  },
  lastRow: {},
  settingLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
    flex: 1,
  },
  settingIcon: {
    width: 36,
    height: 36,
    borderRadius: 9,
    backgroundColor: '#0d1a2e',
    alignItems: 'center',
    justifyContent: 'center',
  },
  settingLabel: {
    color: '#ffffff',
    fontSize: 15,
    fontWeight: '500',
  },
  settingRight: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
  },
  settingValue: {
    color: '#6a6a7a',
    fontSize: 14,
  },
  divider: {
    height: 1,
    backgroundColor: '#1e1e35',
    marginHorizontal: 16,
  },
  footer: {
    color: '#2a2a3e',
    fontSize: 12,
    textAlign: 'center',
    lineHeight: 18,
    marginTop: 8,
  },
});

export default SettingsScreen;
