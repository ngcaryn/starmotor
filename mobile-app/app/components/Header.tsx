import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  StatusBar,
  Platform,
} from 'react-native';
import Colors from '../theme/colors';

interface HeaderProps {
  title: string;
  showBack?: boolean;
  onBack?: () => void;
  /** Text label for the right action button */
  rightLabel?: string;
  onRightPress?: () => void;
  subtitle?: string;
}

// Top navigation header with optional back button and right action label
const Header: React.FC<HeaderProps> = ({
  title,
  showBack = false,
  onBack,
  rightLabel,
  onRightPress,
  subtitle,
}) => {
  return (
    <View style={styles.container}>
      <View style={styles.leftSection}>
        {showBack && (
          <TouchableOpacity
            onPress={onBack}
            style={styles.actionButton}
            accessibilityLabel="Go back"
          >
            <Text style={styles.backText}>‹</Text>
          </TouchableOpacity>
        )}
      </View>

      <View style={styles.centerSection}>
        <Text style={styles.title} numberOfLines={1}>
          {title}
        </Text>
        {subtitle ? (
          <Text style={styles.subtitle} numberOfLines={1}>
            {subtitle}
          </Text>
        ) : null}
      </View>

      <View style={styles.rightSection}>
        {rightLabel && (
          <TouchableOpacity
            onPress={onRightPress}
            style={styles.actionButton}
            accessibilityLabel="Header action"
          >
            <Text style={styles.rightText}>{rightLabel}</Text>
          </TouchableOpacity>
        )}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    backgroundColor: Colors.bgPrimary,
    paddingTop: Platform.OS === 'ios' ? 48 : StatusBar.currentHeight ?? 24,
    paddingBottom: 14,
    paddingHorizontal: 16,
    borderBottomWidth: 1,
    borderBottomColor: Colors.borderDark,
  },
  leftSection: {
    width: 44,
    alignItems: 'flex-start',
  },
  centerSection: {
    flex: 1,
    alignItems: 'center',
  },
  rightSection: {
    width: 44,
    alignItems: 'flex-end',
  },
  title: {
    color: Colors.textPrimary,
    fontSize: 17,
    fontWeight: '600',
    letterSpacing: 0.3,
  },
  subtitle: {
    color: Colors.textSecondary,
    fontSize: 12,
    marginTop: 2,
  },
  actionButton: {
    padding: 4,
  },
  backText: {
    color: Colors.accent,
    fontSize: 28,
    lineHeight: 28,
    fontWeight: '300',
  },
  rightText: {
    color: Colors.accent,
    fontSize: 14,
    fontWeight: '500',
    letterSpacing: 0.3,
  },
});

export default Header;
