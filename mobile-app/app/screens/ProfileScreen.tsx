import React, { useState } from 'react';
import {
  View, Text, StyleSheet, ScrollView, TouchableOpacity, Alert, TextInput,
} from 'react-native';
import { useDispatch, useSelector } from 'react-redux';
import { RootState } from '../store/store';
import { logout, updateProfile } from '../store/authSlice';
import { clearToken } from '../services/api';
import Card from '../components/Card';
import Header from '../components/Header';
import Button from '../components/Button';
import Colors from '../theme/colors';

const ProfileScreen: React.FC<{ navigation: any }> = ({ navigation }) => {
  const dispatch = useDispatch();
  const { user } = useSelector((state: RootState) => state.auth);
  const { rewards } = useSelector((state: RootState) => state.app);

  const [isEditing, setIsEditing] = useState(false);
  const [editName, setEditName] = useState(user?.name ?? '');
  const [editPhone, setEditPhone] = useState(user?.phone ?? '');

  const handleSave = () => {
    if (!editName.trim()) { Alert.alert('Required', 'Name cannot be empty.'); return; }
    dispatch(updateProfile({ name: editName.trim(), phone: editPhone.trim() }));
    setIsEditing(false);
    Alert.alert('Saved', 'Your profile has been updated.');
  };

  const handleLogout = () => {
    Alert.alert('Sign Out', 'Are you sure you want to sign out?', [
      { text: 'Cancel', style: 'cancel' },
      { text: 'Sign Out', style: 'destructive', onPress: async () => { await clearToken(); dispatch(logout()); } },
    ]);
  };

  const handleDeleteAccount = () => {
    Alert.alert('Delete Account', 'This action is irreversible. All your data will be permanently deleted. Are you absolutely sure?', [
      { text: 'Cancel', style: 'cancel' },
      {
        text: 'Delete Account', style: 'destructive',
        onPress: () => Alert.alert('Confirm Deletion', 'Final confirmation — this cannot be undone.', [
          { text: 'Cancel', style: 'cancel' },
          { text: 'Delete', style: 'destructive', onPress: async () => { await clearToken(); dispatch(logout()); } },
        ]),
      },
    ]);
  };

  const MENU_ITEMS = [
    { id: 'events', label: 'My Events', onPress: () => navigation.navigate('Events') },
    { id: 'rewards', label: 'Rewards & Points', onPress: () => navigation.navigate('Rewards') },
    { id: 'service', label: 'Support', onPress: () => navigation.navigate('CustomerService') },
    { id: 'settings', label: 'Settings', onPress: () => navigation.navigate('Settings') },
  ];

  return (
    <View style={styles.container}>
      <Header title="Profile" rightLabel={isEditing ? '' : 'Edit'} onRightPress={() => setIsEditing(true)} />
      <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
        {/* Avatar */}
        <View style={styles.avatarSection}>
          <View style={styles.avatarCircle}>
            <Text style={styles.avatarInitial}>
              {(user?.name ?? 'U').charAt(0).toUpperCase()}
            </Text>
          </View>
          <Text style={styles.profileName}>{user?.name ?? '—'}</Text>
          <Text style={styles.profileEmail}>{user?.email ?? '—'}</Text>
          <View style={styles.tierBadge}>
            <Text style={styles.tierText}>SILVER MEMBER</Text>
          </View>
        </View>

        {/* Points summary */}
        <Card style={styles.pointsCard} active>
          <Text style={styles.pointsLabel}>STAR POINTS</Text>
          <Text style={styles.pointsValue}>{rewards.balance.toLocaleString()}</Text>
        </Card>

        {/* Edit form */}
        {isEditing && (
          <Card style={styles.editCard}>
            <Text style={styles.sectionTitle}>Edit Profile</Text>
            <Text style={styles.fieldLabel}>NAME</Text>
            <TextInput style={styles.fieldInput} value={editName} onChangeText={setEditName} placeholder="Your name" placeholderTextColor={Colors.textDim} />
            <Text style={styles.fieldLabel}>PHONE</Text>
            <TextInput style={styles.fieldInput} value={editPhone} onChangeText={setEditPhone} placeholder="+1 000 000 0000" placeholderTextColor={Colors.textDim} keyboardType="phone-pad" />
            <View style={styles.editActions}>
              <Button title="Save" onPress={handleSave} size="small" />
              <Button title="Cancel" onPress={() => setIsEditing(false)} variant="ghost" size="small" />
            </View>
          </Card>
        )}

        {/* Menu */}
        <View style={styles.menuSection}>
          {MENU_ITEMS.map((item) => (
            <TouchableOpacity key={item.id} style={styles.menuItem} onPress={item.onPress}>
              <Text style={styles.menuLabel}>{item.label}</Text>
              <Text style={styles.menuArrow}>›</Text>
            </TouchableOpacity>
          ))}
        </View>

        {/* Account actions */}
        <View style={styles.dangerSection}>
          <TouchableOpacity style={styles.logoutButton} onPress={handleLogout}>
            <Text style={styles.logoutText}>Sign Out</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.deleteButton} onPress={handleDeleteAccount}>
            <Text style={styles.deleteText}>Delete Account</Text>
          </TouchableOpacity>
        </View>
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: Colors.bgPrimary },
  content: { paddingBottom: 40 },
  avatarSection: { alignItems: 'center', paddingVertical: 28 },
  avatarCircle: { width: 72, height: 72, borderRadius: 36, backgroundColor: Colors.bgCard, borderWidth: 1, borderColor: Colors.border, alignItems: 'center', justifyContent: 'center', marginBottom: 12 },
  avatarInitial: { color: Colors.accent, fontSize: 28, fontWeight: '300' },
  profileName: { color: Colors.textPrimary, fontSize: 20, fontWeight: '600', marginBottom: 4 },
  profileEmail: { color: Colors.textSecondary, fontSize: 13, marginBottom: 8 },
  tierBadge: { backgroundColor: Colors.bgCard, borderRadius: 4, paddingHorizontal: 10, paddingVertical: 3, borderWidth: 1, borderColor: Colors.border },
  tierText: { color: Colors.accentDim, fontSize: 9, fontWeight: '600', letterSpacing: 1.5 },
  pointsCard: { marginHorizontal: 16 },
  pointsLabel: { color: Colors.accentDim, fontSize: 10, fontWeight: '600', letterSpacing: 2, marginBottom: 4 },
  pointsValue: { color: Colors.textPrimary, fontSize: 34, fontWeight: '600' },
  editCard: { marginHorizontal: 16, marginTop: 12 },
  sectionTitle: { color: Colors.textPrimary, fontSize: 15, fontWeight: '600', marginBottom: 14 },
  fieldLabel: { color: Colors.textDim, fontSize: 10, fontWeight: '600', letterSpacing: 1.5, marginBottom: 6, marginTop: 10 },
  fieldInput: { backgroundColor: Colors.bgInset, borderRadius: 6, borderWidth: 1, borderColor: Colors.border, color: Colors.textPrimary, fontSize: 14, paddingHorizontal: 12, paddingVertical: 11 },
  editActions: { flexDirection: 'row', gap: 8, marginTop: 16 },
  menuSection: { marginHorizontal: 16, marginTop: 20, backgroundColor: Colors.bgCard, borderRadius: 8, borderWidth: 1, borderColor: Colors.border, overflow: 'hidden' },
  menuItem: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', paddingHorizontal: 16, paddingVertical: 14, borderBottomWidth: 1, borderBottomColor: Colors.borderDark },
  menuLabel: { color: Colors.textPrimary, fontSize: 14, fontWeight: '400' },
  menuArrow: { color: Colors.accentDim, fontSize: 20, fontWeight: '300' },
  dangerSection: { marginHorizontal: 16, marginTop: 24 },
  logoutButton: { backgroundColor: Colors.bgCard, borderRadius: 6, borderWidth: 1, borderColor: Colors.border, padding: 14, alignItems: 'center', marginBottom: 8 },
  logoutText: { color: Colors.textPrimary, fontSize: 14, fontWeight: '500' },
  deleteButton: { padding: 14, alignItems: 'center' },
  deleteText: { color: Colors.danger, fontSize: 13, fontWeight: '400' },
});

export default ProfileScreen;
