import React from 'react';
import { View, StyleSheet, ViewStyle } from 'react-native';
import Colors from '../theme/colors';

interface CardProps {
  children: React.ReactNode;
  style?: ViewStyle;
  noPadding?: boolean;
  /** Adds a bright border for the active/selected state */
  active?: boolean;
}

// Reusable card container with metallic surface styling
const Card: React.FC<CardProps> = ({
  children,
  style,
  noPadding = false,
  active = false,
}) => {
  return (
    <View
      style={[
        styles.card,
        noPadding && styles.noPadding,
        active && styles.activeCard,
        style,
      ]}
    >
      {children}
    </View>
  );
};

const styles = StyleSheet.create({
  card: {
    backgroundColor: Colors.bgCard,
    borderRadius: 10,
    padding: 16,
    marginVertical: 6,
    borderWidth: 1,
    borderColor: Colors.border,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 6,
    elevation: 4,
  },
  noPadding: {
    padding: 0,
    overflow: 'hidden',
  },
  activeCard: {
    borderColor: Colors.borderActive,
  },
});

export default Card;
