import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Alert,
  TextInput,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useDispatch, useSelector } from 'react-redux';
import { RootState } from '../store/store';
import { logout, updateProfile } from '../store/authSlice';
import { clearToken } from '../services/api';
import Card from '../components/Card';
import Header from '../components/Header';
import Button from '../components/Button';

const ProfileScreen: React.FC<{ navigation: any }> = ({ navigation }) => {
  const dispatch = useDispatch();
  const { user } = useSelector((state: RootState) => state.auth);
  const { rewards } = useSelector((state: RootState) => state.app);

  const [isEditing, setIsEditing] = useState(false);
  const [editName, setEditName] = useState(user?.name ?? '');
  const [editPhone, setEditPhone] = useState(user?.phone ?? '');

  const handleSave = () => {
    if (!editName.trim()) {
      Alert.alert('Required', 'Name cannot be empty.');
      return;
    }
    dispatch(updateProfile({ name: editName.trim(), phone: editPhone.trim() }));
    setIsEditing(false);
    Alert.alert('Saved', 'Your profile has been updated.');
  };

  const handleLogout = () => {
    Alert.alert('Sign Out', 'Are you sure you want to sign out?', [
      { text: 'Cancel', style: 'cancel' },
      {
        text: 'Sign Out',
        style: 'destructive',
        onPress: async () => {
          await clearToken();
          dispatch(logout());
        },
      },
    ]);
  };

  const handleDeleteAccount = () => {
    Alert.alert(
      'Delete Account',
      'This action is irreversible. All your data will be permanently deleted. Are you absolutely sure?',
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Delete Account',
          style: 'destructive',
          onPress: () => {
            Alert.alert(
              'Account Deleted',
              'Your account has been scheduled for deletion. You will receive a confirmation email.'
            );
            dispatch(logout());
          },
        },
      ]
    );
  };

  const MENU_ITEMS = [
    {
      id: 'orders',
      icon: 'bag-handle-outline',
      label: 'My Orders',
      onPress: () => Alert.alert('Orders', 'Order management coming soon.'),
    },
    {
      id: 'vehicles',
      icon: 'car-sport-outline',
      label: 'My Vehicles',
      onPress: () => navigation.navigate('Vehicles'),
    },
    {
      id: 'rewards',
      icon: 'star-outline',
      label: 'Rewards & Points',
      value: `${rewards.balance.toLocaleString()} pts`,
      onPress: () => navigation.navigate('Rewards'),
    },
    {
      id: 'notifications',
      icon: 'notifications-outline',
      label: 'Notifications',
      onPress: () => navigation.navigate('Settings'),
    },
    {
      id: 'privacy',
      icon: 'shield-outline',
      label: 'Privacy Policy',
      onPress: () =>
        Alert.alert(
          'Privacy Policy',
          'StarMotor collects and uses your data to provide personalized services. We never sell your data to third parties.'
        ),
    },
    {
      id: 'terms',
      icon: 'document-text-outline',
      label: 'Terms of Service',
      onPress: () => Alert.alert('Terms of Service', 'View full terms at starmotor.com/terms'),
    },
    {
      id: 'settings',
      icon: 'settings-outline',
      label: 'App Settings',
      onPress: () => navigation.navigate('Settings'),
    },
  ];

  return (
    <View style={styles.container}>
      <Header
        title="My Profile"
        rightIcon={isEditing ? 'checkmark' : 'create-outline'}
        onRightPress={isEditing ? handleSave : () => setIsEditing(true)}
      />

      <ScrollView showsVerticalScrollIndicator={false}>
        {/* Profile avatar section */}
        <View style={styles.avatarSection}>
          <View style={styles.avatarContainer}>
            <Text style={styles.avatarText}>
              {user?.name?.substring(0, 2).toUpperCase() ?? 'SM'}
            </Text>
            <TouchableOpacity style={styles.editAvatarButton}>
              <Ionicons name="camera" size={14} color="#0a0a0f" />
            </TouchableOpacity>
          </View>

          {isEditing ? (
            <View style={styles.editFields}>
              <TextInput
                style={styles.editInput}
                value={editName}
                onChangeText={setEditName}
                placeholder="Full name"
                placeholderTextColor="#4a4a5a"
              />
              <TextInput
                style={styles.editInput}
                value={editPhone}
                onChangeText={setEditPhone}
                placeholder="Phone number"
                placeholderTextColor="#4a4a5a"
                keyboardType="phone-pad"
              />
              <View style={styles.editButtons}>
                <Button
                  title="Save"
                  onPress={handleSave}
                  size="small"
                  style={{ flex: 1 }}
                />
                <Button
                  title="Cancel"
                  onPress={() => setIsEditing(false)}
                  variant="outline"
                  size="small"
                  style={{ flex: 1 }}
                />
              </View>
            </View>
          ) : (
            <View style={styles.profileInfo}>
              <Text style={styles.profileName}>{user?.name ?? 'StarMotor User'}</Text>
              <Text style={styles.profileEmail}>{user?.email ?? ''}</Text>
              {user?.phone ? (
                <Text style={styles.profilePhone}>{user.phone}</Text>
              ) : null}
            </View>
          )}
        </View>

        {/* Stats row */}
        <View style={styles.statsRow}>
          <View style={styles.statItem}>
            <Text style={styles.statValue}>{rewards.balance.toLocaleString()}</Text>
            <Text style={styles.statLabel}>Points</Text>
          </View>
          <View style={styles.statDivider} />
          <View style={styles.statItem}>
            <Text style={styles.statValue}>{rewards.streak}</Text>
            <Text style={styles.statLabel}>Day Streak</Text>
          </View>
          <View style={styles.statDivider} />
          <View style={styles.statItem}>
            <Text style={styles.statValue}>0</Text>
            <Text style={styles.statLabel}>Vehicles</Text>
          </View>
        </View>

        {/* Menu items */}
        <View style={styles.menuSection}>
          {MENU_ITEMS.map((item) => (
            <TouchableOpacity
              key={item.id}
              style={styles.menuItem}
              onPress={item.onPress}
            >
              <View style={styles.menuItemLeft}>
                <View style={styles.menuItemIcon}>
                  <Ionicons name={item.icon as any} size={20} color="#00d4ff" />
                </View>
                <Text style={styles.menuItemLabel}>{item.label}</Text>
              </View>
              <View style={styles.menuItemRight}>
                {item.value ? (
                  <Text style={styles.menuItemValue}>{item.value}</Text>
                ) : null}
                <Ionicons name="chevron-forward" size={16} color="#4a4a5a" />
              </View>
            </TouchableOpacity>
          ))}
        </View>

        {/* Danger zone */}
        <View style={styles.dangerZone}>
          <Button
            title="Sign Out"
            onPress={handleLogout}
            variant="outline"
            fullWidth
            size="large"
            style={styles.signOutButton}
          />
          <TouchableOpacity
            style={styles.deleteAccountButton}
            onPress={handleDeleteAccount}
          >
            <Ionicons name="trash-outline" size={16} color="#ff4d6d" />
            <Text style={styles.deleteAccountText}>Delete Account</Text>
          </TouchableOpacity>
        </View>
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0a0a0f',
  },
  avatarSection: {
    alignItems: 'center',
    paddingVertical: 24,
    paddingHorizontal: 20,
  },
  avatarContainer: {
    width: 90,
    height: 90,
    borderRadius: 45,
    backgroundColor: '#0d1a2e',
    borderWidth: 3,
    borderColor: '#00d4ff',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 16,
    position: 'relative',
    shadowColor: '#00d4ff',
    shadowOffset: { width: 0, height: 0 },
    shadowOpacity: 0.3,
    shadowRadius: 10,
    elevation: 8,
  },
  avatarText: {
    color: '#00d4ff',
    fontSize: 28,
    fontWeight: '800',
  },
  editAvatarButton: {
    position: 'absolute',
    bottom: 0,
    right: 0,
    width: 26,
    height: 26,
    borderRadius: 13,
    backgroundColor: '#00d4ff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  profileInfo: {
    alignItems: 'center',
  },
  profileName: {
    color: '#ffffff',
    fontSize: 22,
    fontWeight: '700',
    marginBottom: 4,
  },
  profileEmail: {
    color: '#6a6a7a',
    fontSize: 14,
    marginBottom: 2,
  },
  profilePhone: {
    color: '#6a6a7a',
    fontSize: 14,
  },
  editFields: {
    width: '100%',
    gap: 10,
  },
  editInput: {
    backgroundColor: '#12121f',
    borderRadius: 10,
    borderWidth: 1,
    borderColor: '#2a2a3e',
    color: '#ffffff',
    fontSize: 15,
    paddingHorizontal: 14,
    paddingVertical: 12,
  },
  editButtons: {
    flexDirection: 'row',
    gap: 10,
  },
  statsRow: {
    flexDirection: 'row',
    backgroundColor: '#12121f',
    marginHorizontal: 16,
    borderRadius: 14,
    padding: 16,
    borderWidth: 1,
    borderColor: '#1e1e35',
    marginBottom: 20,
  },
  statItem: {
    flex: 1,
    alignItems: 'center',
  },
  statValue: {
    color: '#ffffff',
    fontSize: 20,
    fontWeight: '800',
    marginBottom: 2,
  },
  statLabel: {
    color: '#6a6a7a',
    fontSize: 12,
  },
  statDivider: {
    width: 1,
    backgroundColor: '#1e1e35',
  },
  menuSection: {
    paddingHorizontal: 16,
    marginBottom: 8,
  },
  menuItem: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingVertical: 14,
    borderBottomWidth: 1,
    borderBottomColor: '#1e1e35',
  },
  menuItemLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
  },
  menuItemIcon: {
    width: 38,
    height: 38,
    borderRadius: 10,
    backgroundColor: '#0d1a2e',
    alignItems: 'center',
    justifyContent: 'center',
  },
  menuItemLabel: {
    color: '#ffffff',
    fontSize: 15,
    fontWeight: '500',
  },
  menuItemRight: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
  },
  menuItemValue: {
    color: '#00d4ff',
    fontSize: 13,
    fontWeight: '600',
  },
  dangerZone: {
    padding: 20,
    paddingTop: 8,
    gap: 12,
  },
  signOutButton: {},
  deleteAccountButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 6,
    paddingVertical: 12,
  },
  deleteAccountText: {
    color: '#ff4d6d',
    fontSize: 14,
    fontWeight: '600',
  },
});

export default ProfileScreen;
