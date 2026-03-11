import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Alert,
  Animated,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useDispatch, useSelector } from 'react-redux';
import { RootState } from '../store/store';
import { performCheckIn, redeemPoints } from '../store/appSlice';
import Card from '../components/Card';
import Header from '../components/Header';
import Button from '../components/Button';

const REWARDS_CATALOG = [
  {
    id: 'r1',
    name: 'Service Discount Voucher',
    description: '10% off your next service appointment',
    points: 500,
    icon: 'build',
    category: 'Service',
  },
  {
    id: 'r2',
    name: 'StarMotor Branded Polo',
    description: 'Premium branded polo shirt',
    points: 1000,
    icon: 'shirt',
    category: 'Merchandise',
  },
  {
    id: 'r3',
    name: 'Charging Credits ($50)',
    description: '$50 credit for StarCharge network',
    points: 1500,
    icon: 'flash',
    category: 'Charging',
  },
  {
    id: 'r4',
    name: 'Extended Warranty (1 Year)',
    description: 'One additional year of comprehensive warranty coverage',
    points: 5000,
    icon: 'shield-checkmark',
    category: 'Coverage',
  },
  {
    id: 'r5',
    name: 'Track Day Pass',
    description: 'Exclusive access to our branded track day event',
    points: 3000,
    icon: 'flag',
    category: 'Experience',
  },
  {
    id: 'r6',
    name: 'Home Charging Upgrade',
    description: 'Professional installation of Level 2 home charger',
    points: 8000,
    icon: 'home',
    category: 'Charging',
  },
];

const HOW_TO_EARN = [
  { action: 'Daily Check-in', points: 50, icon: 'checkmark-circle' },
  { action: 'Vehicle Purchase', points: 10000, icon: 'car-sport' },
  { action: 'Referral', points: 2000, icon: 'person-add' },
  { action: 'Event Attendance', points: 500, icon: 'calendar' },
  { action: 'Community Post', points: 100, icon: 'chatbubbles' },
  { action: 'Profile Completion', points: 200, icon: 'person' },
];

const RewardsScreen: React.FC = () => {
  const dispatch = useDispatch();
  const { rewards } = useSelector((state: RootState) => state.app);
  const [activeTab, setActiveTab] = useState<'earn' | 'redeem' | 'history'>('earn');

  const today = new Date().toISOString().split('T')[0];
  const canCheckIn = rewards.lastCheckIn !== today;

  const handleCheckIn = () => {
    if (canCheckIn) {
      dispatch(performCheckIn());
      Alert.alert(
        '🎉 Check-in Successful!',
        `You earned 50 Star Points!\nCurrent streak: ${rewards.streak + 1} days`
      );
    }
  };

  const handleRedeem = (item: (typeof REWARDS_CATALOG)[0]) => {
    if (rewards.balance < item.points) {
      Alert.alert(
        'Insufficient Points',
        `You need ${(item.points - rewards.balance).toLocaleString()} more points to redeem this reward.`
      );
      return;
    }
    Alert.alert(
      'Redeem Reward',
      `Redeem "${item.name}" for ${item.points.toLocaleString()} points?`,
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Redeem',
          onPress: () => {
            dispatch(redeemPoints(item.points));
            Alert.alert(
              '✅ Redeemed!',
              `"${item.name}" has been redeemed. Your reward will be processed within 2 business days.`
            );
          },
        },
      ]
    );
  };

  return (
    <View style={styles.container}>
      <Header title="Star Rewards" subtitle="Earn & redeem exclusive benefits" />

      <ScrollView showsVerticalScrollIndicator={false}>
        {/* Points overview */}
        <Card style={styles.pointsCard} glowAccent>
          <View style={styles.pointsHeader}>
            <View>
              <Text style={styles.pointsLabel}>STAR POINTS BALANCE</Text>
              <Text style={styles.pointsBalance}>
                {rewards.balance.toLocaleString()}
              </Text>
            </View>
            <View style={styles.streakContainer}>
              <Text style={styles.streakEmoji}>🔥</Text>
              <Text style={styles.streakCount}>{rewards.streak}</Text>
              <Text style={styles.streakLabel}>day streak</Text>
            </View>
          </View>

          <View style={styles.pointsStats}>
            <View style={styles.statItem}>
              <Text style={styles.statValue}>
                {rewards.totalEarned.toLocaleString()}
              </Text>
              <Text style={styles.statLabel}>Total Earned</Text>
            </View>
            <View style={styles.statDivider} />
            <View style={styles.statItem}>
              <Text style={styles.statValue}>
                {(rewards.totalEarned - rewards.balance).toLocaleString()}
              </Text>
              <Text style={styles.statLabel}>Total Redeemed</Text>
            </View>
          </View>

          {/* Daily check-in button */}
          <TouchableOpacity
            style={[styles.checkInButton, !canCheckIn && styles.checkInButtonUsed]}
            onPress={handleCheckIn}
            disabled={!canCheckIn}
          >
            <Ionicons
              name={canCheckIn ? 'checkmark-circle-outline' : 'checkmark-circle'}
              size={20}
              color={canCheckIn ? '#0a0a0f' : '#4a4a5a'}
            />
            <Text
              style={[styles.checkInText, !canCheckIn && styles.checkInTextUsed]}
            >
              {canCheckIn ? 'Daily Check-in (+50 pts)' : 'Checked in today ✓'}
            </Text>
          </TouchableOpacity>
        </Card>

        {/* Tab navigation */}
        <View style={styles.tabRow}>
          {(['earn', 'redeem', 'history'] as const).map((tab) => (
            <TouchableOpacity
              key={tab}
              style={[styles.tab, activeTab === tab && styles.tabActive]}
              onPress={() => setActiveTab(tab)}
            >
              <Text
                style={[styles.tabText, activeTab === tab && styles.tabTextActive]}
              >
                {tab.charAt(0).toUpperCase() + tab.slice(1)}
              </Text>
            </TouchableOpacity>
          ))}
        </View>

        {/* Earn tab */}
        {activeTab === 'earn' && (
          <View style={styles.tabContent}>
            <Text style={styles.sectionTitle}>Ways to Earn Points</Text>
            {HOW_TO_EARN.map((item) => (
              <Card key={item.action} style={styles.earnCard}>
                <View style={styles.earnRow}>
                  <View style={styles.earnIcon}>
                    <Ionicons name={item.icon as any} size={22} color="#00d4ff" />
                  </View>
                  <Text style={styles.earnAction}>{item.action}</Text>
                  <View style={styles.earnPointsBadge}>
                    <Text style={styles.earnPointsText}>
                      +{item.points.toLocaleString()}
                    </Text>
                  </View>
                </View>
              </Card>
            ))}
          </View>
        )}

        {/* Redeem tab */}
        {activeTab === 'redeem' && (
          <View style={styles.tabContent}>
            <Text style={styles.sectionTitle}>Available Rewards</Text>
            {REWARDS_CATALOG.map((item) => {
              const canAfford = rewards.balance >= item.points;
              return (
                <Card key={item.id} style={styles.rewardCard}>
                  <View style={styles.rewardRow}>
                    <View style={[styles.rewardIcon, !canAfford && styles.rewardIconDisabled]}>
                      <Ionicons name={item.icon as any} size={24} color={canAfford ? '#00d4ff' : '#4a4a5a'} />
                    </View>
                    <View style={styles.rewardInfo}>
                      <Text style={styles.rewardName}>{item.name}</Text>
                      <Text style={styles.rewardDescription} numberOfLines={2}>
                        {item.description}
                      </Text>
                      <Text style={[styles.rewardPoints, !canAfford && styles.rewardPointsInsufficient]}>
                        {item.points.toLocaleString()} pts
                        {!canAfford && ` (need ${(item.points - rewards.balance).toLocaleString()} more)`}
                      </Text>
                    </View>
                    <Button
                      title="Redeem"
                      onPress={() => handleRedeem(item)}
                      variant={canAfford ? 'primary' : 'outline'}
                      size="small"
                      disabled={!canAfford}
                    />
                  </View>
                </Card>
              );
            })}
          </View>
        )}

        {/* History tab */}
        {activeTab === 'history' && (
          <View style={styles.tabContent}>
            <Text style={styles.sectionTitle}>Points History</Text>
            {rewards.totalEarned === 0 ? (
              <View style={styles.emptyHistory}>
                <Ionicons name="time-outline" size={48} color="#2a2a3e" />
                <Text style={styles.emptyHistoryText}>No activity yet</Text>
                <Text style={styles.emptyHistorySubtext}>
                  Start earning points by checking in daily
                </Text>
              </View>
            ) : (
              <Card style={styles.historyCard}>
                <View style={styles.historyRow}>
                  <Ionicons name="checkmark-circle" size={18} color="#00d4ff" />
                  <View style={styles.historyInfo}>
                    <Text style={styles.historyAction}>Daily Check-in</Text>
                    <Text style={styles.historyDate}>Today</Text>
                  </View>
                  <Text style={styles.historyPoints}>+50 pts</Text>
                </View>
              </Card>
            )}
          </View>
        )}
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0a0a0f',
  },
  pointsCard: {
    margin: 16,
    backgroundColor: '#0d1a2e',
  },
  pointsHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: 16,
  },
  pointsLabel: {
    color: '#00d4ff',
    fontSize: 11,
    fontWeight: '700',
    letterSpacing: 2,
    marginBottom: 4,
  },
  pointsBalance: {
    color: '#ffffff',
    fontSize: 40,
    fontWeight: '800',
  },
  streakContainer: {
    alignItems: 'center',
    backgroundColor: '#12121f',
    borderRadius: 12,
    padding: 12,
    borderWidth: 1,
    borderColor: '#ff6b2b33',
  },
  streakEmoji: {
    fontSize: 24,
    marginBottom: 2,
  },
  streakCount: {
    color: '#ff6b2b',
    fontSize: 22,
    fontWeight: '800',
  },
  streakLabel: {
    color: '#6a6a7a',
    fontSize: 11,
  },
  pointsStats: {
    flexDirection: 'row',
    backgroundColor: '#12121f',
    borderRadius: 10,
    padding: 14,
    marginBottom: 14,
  },
  statItem: {
    flex: 1,
    alignItems: 'center',
  },
  statValue: {
    color: '#ffffff',
    fontSize: 18,
    fontWeight: '700',
  },
  statLabel: {
    color: '#6a6a7a',
    fontSize: 11,
    marginTop: 2,
  },
  statDivider: {
    width: 1,
    backgroundColor: '#1e1e35',
    marginHorizontal: 10,
  },
  checkInButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 8,
    backgroundColor: '#00d4ff',
    borderRadius: 10,
    paddingVertical: 12,
  },
  checkInButtonUsed: {
    backgroundColor: '#1e1e35',
  },
  checkInText: {
    color: '#0a0a0f',
    fontWeight: '700',
    fontSize: 15,
  },
  checkInTextUsed: {
    color: '#4a4a5a',
  },
  tabRow: {
    flexDirection: 'row',
    marginHorizontal: 16,
    backgroundColor: '#12121f',
    borderRadius: 12,
    padding: 4,
    marginBottom: 4,
    borderWidth: 1,
    borderColor: '#1e1e35',
  },
  tab: {
    flex: 1,
    paddingVertical: 10,
    alignItems: 'center',
    borderRadius: 9,
  },
  tabActive: {
    backgroundColor: '#00d4ff',
  },
  tabText: {
    color: '#6a6a7a',
    fontSize: 14,
    fontWeight: '600',
  },
  tabTextActive: {
    color: '#0a0a0f',
    fontWeight: '700',
  },
  tabContent: {
    padding: 16,
  },
  sectionTitle: {
    color: '#ffffff',
    fontSize: 17,
    fontWeight: '700',
    marginBottom: 14,
  },
  earnCard: {
    marginBottom: 8,
    padding: 14,
  },
  earnRow: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  earnIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#0d1a2e',
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 12,
  },
  earnAction: {
    flex: 1,
    color: '#ffffff',
    fontSize: 15,
    fontWeight: '600',
  },
  earnPointsBadge: {
    backgroundColor: '#00d4ff22',
    borderRadius: 8,
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderWidth: 1,
    borderColor: '#00d4ff44',
  },
  earnPointsText: {
    color: '#00d4ff',
    fontSize: 13,
    fontWeight: '700',
  },
  rewardCard: {
    marginBottom: 10,
  },
  rewardRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
  },
  rewardIcon: {
    width: 50,
    height: 50,
    borderRadius: 12,
    backgroundColor: '#0d1a2e',
    alignItems: 'center',
    justifyContent: 'center',
    borderWidth: 1,
    borderColor: '#00d4ff33',
  },
  rewardIconDisabled: {
    borderColor: '#2a2a3e',
    backgroundColor: '#12121f',
  },
  rewardInfo: {
    flex: 1,
  },
  rewardName: {
    color: '#ffffff',
    fontSize: 14,
    fontWeight: '700',
    marginBottom: 3,
  },
  rewardDescription: {
    color: '#6a6a7a',
    fontSize: 12,
    lineHeight: 16,
    marginBottom: 4,
  },
  rewardPoints: {
    color: '#00d4ff',
    fontSize: 13,
    fontWeight: '700',
  },
  rewardPointsInsufficient: {
    color: '#ff4d6d',
  },
  historyCard: {
    padding: 14,
  },
  historyRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
  },
  historyInfo: {
    flex: 1,
  },
  historyAction: {
    color: '#ffffff',
    fontSize: 14,
    fontWeight: '600',
  },
  historyDate: {
    color: '#6a6a7a',
    fontSize: 12,
  },
  historyPoints: {
    color: '#00d4ff',
    fontSize: 15,
    fontWeight: '700',
  },
  emptyHistory: {
    alignItems: 'center',
    paddingVertical: 40,
  },
  emptyHistoryText: {
    color: '#ffffff',
    fontSize: 18,
    fontWeight: '700',
    marginTop: 12,
    marginBottom: 6,
  },
  emptyHistorySubtext: {
    color: '#4a4a5a',
    fontSize: 13,
    textAlign: 'center',
  },
});

export default RewardsScreen;
