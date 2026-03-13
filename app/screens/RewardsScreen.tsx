import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, FlatList, Alert } from 'react-native';
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../store/store';
import { performCheckIn, redeemPoints } from '../store/appSlice';
import Card from '../components/Card';
import Header from '../components/Header';
import Colors from '../theme/colors';

const REWARDS_CATALOG = [
  { id: 'r1', title: 'Free Car Wash', points: 500, category: 'Service' },
  { id: 'r2', title: 'StarMotor Store $50 Credit', points: 1000, category: 'Store' },
  { id: 'r3', title: 'Priority Service Booking', points: 1500, category: 'Service' },
  { id: 'r4', title: 'Test Drive — Next Model', points: 2000, category: 'Experience' },
  { id: 'r5', title: 'Exclusive Track Day Pass', points: 5000, category: 'Experience' },
];

const HISTORY = [
  { id: 'h1', action: 'Daily check-in', points: '+10', date: 'Today' },
  { id: 'h2', action: 'Test drive completed', points: '+250', date: 'Jun 10' },
  { id: 'h3', action: 'Event registration', points: '+50', date: 'Jun 8' },
  { id: 'h4', action: 'Redeemed: Free Car Wash', points: '−500', date: 'Jun 5' },
];

const RewardsScreen: React.FC<{ navigation: any }> = ({ navigation }) => {
  const dispatch = useDispatch();
  const { rewards } = useSelector((state: RootState) => state.app);
  const [tab, setTab] = useState<'catalog' | 'history'>('catalog');

  const today = new Date().toISOString().split('T')[0];

  const handleCheckIn = () => {
    if (rewards.lastCheckIn === today) {
      Alert.alert('Already Checked In', 'Come back tomorrow to earn more points.'); return;
    }
    dispatch(performCheckIn());
    Alert.alert('Check-in Complete', '+50 Star Points added to your balance.');
  };

  const handleRedeem = (item: typeof REWARDS_CATALOG[number]) => {
    if (rewards.balance < item.points) {
      Alert.alert('Insufficient Points', `You need ${item.points - rewards.balance} more points.`); return;
    }
    Alert.alert('Redeem Reward', `Redeem "${item.title}" for ${item.points} points?`, [
      { text: 'Cancel', style: 'cancel' },
      { text: 'Confirm', onPress: () => { dispatch(redeemPoints(item.points)); Alert.alert('Redeemed', `"${item.title}" will be processed within 24 hours.`); } },
    ]);
  };

  return (
    <View style={styles.container}>
      <Header title="Rewards" showBack onBack={() => navigation.goBack()} />
      <ScrollView showsVerticalScrollIndicator={false}>
        {/* Balance card */}
        <Card style={styles.balanceCard} active>
          <Text style={styles.balanceLabel}>STAR POINTS BALANCE</Text>
          <Text style={styles.balanceValue}>{rewards.balance.toLocaleString()}</Text>
          <View style={styles.streakRow}>
            <Text style={styles.streakLabel}>Current streak</Text>
            <Text style={styles.streakValue}>{rewards.streak} days</Text>
          </View>
          <TouchableOpacity
            style={[styles.checkInButton, rewards.lastCheckIn === today && styles.checkInDisabled]}
            onPress={handleCheckIn}
          >
            <Text style={styles.checkInText}>
              {rewards.lastCheckIn === today ? 'Checked In Today' : 'Daily Check-In  +50 pts'}
            </Text>
          </TouchableOpacity>
        </Card>

        {/* Tabs */}
        <View style={styles.tabRow}>
          {(['catalog', 'history'] as const).map((t) => (
            <TouchableOpacity key={t} style={[styles.tab, tab === t && styles.tabActive]} onPress={() => setTab(t)}>
              <Text style={[styles.tabText, tab === t && styles.tabTextActive]}>
                {t === 'catalog' ? 'Rewards' : 'History'}
              </Text>
            </TouchableOpacity>
          ))}
        </View>

        {tab === 'catalog' ? (
          <View style={styles.catalogContent}>
            {REWARDS_CATALOG.map((item) => (
              <Card key={item.id} style={styles.rewardItem}>
                <View style={styles.rewardRow}>
                  <View style={{ flex: 1 }}>
                    <Text style={styles.rewardCategory}>{item.category.toUpperCase()}</Text>
                    <Text style={styles.rewardTitle}>{item.title}</Text>
                  </View>
                  <TouchableOpacity
                    style={[styles.redeemButton, rewards.balance < item.points && styles.redeemButtonDisabled]}
                    onPress={() => handleRedeem(item)}
                  >
                    <Text style={[styles.redeemButtonText, rewards.balance < item.points && styles.redeemButtonTextDisabled]}>
                      {item.points.toLocaleString()} pts
                    </Text>
                  </TouchableOpacity>
                </View>
              </Card>
            ))}
          </View>
        ) : (
          <View style={styles.historyContent}>
            {HISTORY.map((entry) => (
              <View key={entry.id} style={styles.historyRow}>
                <View style={{ flex: 1 }}>
                  <Text style={styles.historyAction}>{entry.action}</Text>
                  <Text style={styles.historyDate}>{entry.date}</Text>
                </View>
                <Text style={[styles.historyPoints, entry.points.startsWith('+') ? styles.historyEarn : styles.historySpend]}>
                  {entry.points}
                </Text>
              </View>
            ))}
          </View>
        )}
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: Colors.bgPrimary },
  balanceCard: { marginHorizontal: 16, marginTop: 16 },
  balanceLabel: { color: Colors.accentDim, fontSize: 10, fontWeight: '600', letterSpacing: 2, marginBottom: 6 },
  balanceValue: { color: Colors.textPrimary, fontSize: 42, fontWeight: '600', marginBottom: 8 },
  streakRow: { flexDirection: 'row', justifyContent: 'space-between', marginBottom: 14 },
  streakLabel: { color: Colors.textSecondary, fontSize: 13 },
  streakValue: { color: Colors.accent, fontSize: 13, fontWeight: '600' },
  checkInButton: { backgroundColor: Colors.accent, borderRadius: 6, padding: 12, alignItems: 'center' },
  checkInDisabled: { backgroundColor: Colors.bgElevated },
  checkInText: { color: Colors.bgPrimary, fontSize: 13, fontWeight: '600', letterSpacing: 0.3 },
  tabRow: { flexDirection: 'row', marginHorizontal: 16, marginTop: 20, borderRadius: 6, borderWidth: 1, borderColor: Colors.border, overflow: 'hidden' },
  tab: { flex: 1, paddingVertical: 10, alignItems: 'center', backgroundColor: Colors.bgCard },
  tabActive: { backgroundColor: Colors.bgElevated },
  tabText: { color: Colors.textSecondary, fontSize: 13, fontWeight: '500' },
  tabTextActive: { color: Colors.accent },
  catalogContent: { padding: 16 },
  rewardItem: { marginBottom: 6 },
  rewardRow: { flexDirection: 'row', alignItems: 'center' },
  rewardCategory: { color: Colors.textDim, fontSize: 9, fontWeight: '600', letterSpacing: 1.5, marginBottom: 3 },
  rewardTitle: { color: Colors.textPrimary, fontSize: 14, fontWeight: '500' },
  redeemButton: { backgroundColor: Colors.accent, borderRadius: 5, paddingHorizontal: 12, paddingVertical: 7 },
  redeemButtonDisabled: { backgroundColor: Colors.bgElevated, borderWidth: 1, borderColor: Colors.border },
  redeemButtonText: { color: Colors.bgPrimary, fontSize: 12, fontWeight: '600' },
  redeemButtonTextDisabled: { color: Colors.textDim },
  historyContent: { padding: 16 },
  historyRow: { flexDirection: 'row', paddingVertical: 12, borderBottomWidth: 1, borderBottomColor: Colors.borderDark },
  historyAction: { color: Colors.textPrimary, fontSize: 14, marginBottom: 2 },
  historyDate: { color: Colors.textDim, fontSize: 12 },
  historyPoints: { fontSize: 15, fontWeight: '600' },
  historyEarn: { color: Colors.success },
  historySpend: { color: Colors.textSecondary },
});

export default RewardsScreen;
