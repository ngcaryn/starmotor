import React from 'react';
import { View, StyleSheet, ViewStyle } from 'react-native';

interface CardProps {
  children: React.ReactNode;
  style?: ViewStyle;
  noPadding?: boolean;
  glowAccent?: boolean;
}

// Reusable card container with dark theme and optional neon glow accent
const Card: React.FC<CardProps> = ({
  children,
  style,
  noPadding = false,
  glowAccent = false,
}) => {
  return (
    <View
      style={[
        styles.card,
        noPadding && styles.noPadding,
        glowAccent && styles.glowAccent,
        style,
      ]}
    >
      {children}
    </View>
  );
};

const styles = StyleSheet.create({
  card: {
    backgroundColor: '#12121f',
    borderRadius: 12,
    padding: 16,
    marginVertical: 8,
    borderWidth: 1,
    borderColor: '#1e1e35',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 6,
  },
  noPadding: {
    padding: 0,
    overflow: 'hidden',
  },
  glowAccent: {
    borderColor: '#00d4ff',
    shadowColor: '#00d4ff',
    shadowOpacity: 0.2,
    shadowRadius: 10,
    elevation: 8,
  },
});

export default Card;
