import React, { useState, useRef } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TextInput,
  TouchableOpacity,
  FlatList,
  Alert,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import Card from '../components/Card';
import Header from '../components/Header';
import Button from '../components/Button';

interface ChatMessage {
  id: string;
  role: 'user' | 'assistant';
  content: string;
  timestamp: string;
}

interface FAQ {
  id: string;
  question: string;
  answer: string;
  category: string;
}

const FAQ_DATA: FAQ[] = [
  {
    id: 'faq1',
    question: 'How do I schedule a service appointment?',
    answer:
      'You can schedule a service appointment through the StarMotor app, by calling our service hotline, or by visiting any authorized StarMotor service center.',
    category: 'Service',
  },
  {
    id: 'faq2',
    question: 'What is the warranty on my vehicle?',
    answer:
      'StarMotor vehicles come with a comprehensive 8-year/150,000 km warranty on the battery and powertrain, and a 4-year/80,000 km warranty on the rest of the vehicle.',
    category: 'Warranty',
  },
  {
    id: 'faq3',
    question: 'How do I access over-the-air software updates?',
    answer:
      'OTA updates are delivered automatically when your vehicle is connected to Wi-Fi. Ensure your vehicle is parked and connected. You will receive a notification when an update is available.',
    category: 'Software',
  },
  {
    id: 'faq4',
    question: 'How long does fast charging take?',
    answer:
      'Using a StarCharge 250kW DC fast charger, you can charge from 10% to 80% in approximately 22 minutes. A full charge from 0% takes approximately 45 minutes.',
    category: 'Charging',
  },
];

const BOT_RESPONSES: Record<string, string> = {
  hello: 'Hello! Welcome to StarMotor support. How can I assist you today?',
  charging: 'For charging questions, StarMotor supports up to 250kW DC fast charging. The StarCharge network has over 10,000 charging points worldwide.',
  service: 'To schedule a service, tap Menu → Service → Book Appointment. Service intervals are every 20,000 km or annually.',
  warranty: 'Your StarMotor comes with an 8-year/150,000 km battery warranty and 4-year comprehensive coverage.',
  default: "I understand you need help with that. Let me connect you with a human agent who can assist you further. Would you like me to create a support ticket?",
};

const SUPPORT_CATEGORIES = ['Technical', 'Charging', 'Warranty', 'Orders', 'Account', 'Other'];

const CustomerServiceScreen: React.FC = () => {
  const [activeTab, setActiveTab] = useState<'chat' | 'faq' | 'ticket'>('chat');
  const [messages, setMessages] = useState<ChatMessage[]>([
    {
      id: 'initial',
      role: 'assistant',
      content:
        'Hello! I\'m STAR AI, your StarMotor virtual assistant. I can help with charging, service, warranty, or vehicle questions. How can I help you today?',
      timestamp: 'Now',
    },
  ]);
  const [inputText, setInputText] = useState('');
  const [expandedFAQ, setExpandedFAQ] = useState<string | null>(null);
  const [ticketCategory, setTicketCategory] = useState('Technical');
  const [ticketDescription, setTicketDescription] = useState('');
  const scrollRef = useRef<ScrollView>(null);

  const getBotResponse = (input: string): string => {
    const lower = input.toLowerCase();
    for (const [key, response] of Object.entries(BOT_RESPONSES)) {
      if (lower.includes(key)) return response;
    }
    return BOT_RESPONSES.default;
  };

  const sendMessage = () => {
    if (!inputText.trim()) return;

    const userMessage: ChatMessage = {
      id: `msg_${Date.now()}`,
      role: 'user',
      content: inputText.trim(),
      timestamp: 'Now',
    };

    setMessages((prev) => [...prev, userMessage]);
    setInputText('');

    // Simulate bot response after a short delay
    setTimeout(() => {
      const botMessage: ChatMessage = {
        id: `bot_${Date.now()}`,
        role: 'assistant',
        content: getBotResponse(userMessage.content),
        timestamp: 'Now',
      };
      setMessages((prev) => [...prev, botMessage]);
      scrollRef.current?.scrollToEnd({ animated: true });
    }, 800);
  };

  const submitTicket = () => {
    if (!ticketDescription.trim()) {
      Alert.alert('Required', 'Please describe your issue before submitting.');
      return;
    }
    Alert.alert(
      '✅ Ticket Created',
      'Your support ticket has been submitted. Ticket ID: #SM-' +
        Math.floor(Math.random() * 90000 + 10000) +
        '\n\nWe will respond within 24 hours.',
      [{ text: 'OK', onPress: () => setTicketDescription('') }]
    );
  };

  return (
    <View style={styles.container}>
      <Header
        title="Customer Service"
        subtitle="24/7 support for you"
      />

      {/* Tab navigation */}
      <View style={styles.tabRow}>
        {(['chat', 'faq', 'ticket'] as const).map((tab) => (
          <TouchableOpacity
            key={tab}
            style={[styles.tab, activeTab === tab && styles.tabActive]}
            onPress={() => setActiveTab(tab)}
          >
            <Ionicons
              name={
                tab === 'chat'
                  ? 'chatbubbles-outline'
                  : tab === 'faq'
                  ? 'help-circle-outline'
                  : 'document-text-outline'
              }
              size={16}
              color={activeTab === tab ? '#0a0a0f' : '#6a6a7a'}
            />
            <Text
              style={[styles.tabText, activeTab === tab && styles.tabTextActive]}
            >
              {tab === 'chat' ? 'AI Chat' : tab === 'faq' ? 'FAQ' : 'Ticket'}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      {/* AI Chat tab */}
      {activeTab === 'chat' && (
        <View style={styles.chatContainer}>
          <ScrollView
            ref={scrollRef}
            style={styles.messageList}
            contentContainerStyle={styles.messageListContent}
            showsVerticalScrollIndicator={false}
            onContentSizeChange={() =>
              scrollRef.current?.scrollToEnd({ animated: true })
            }
          >
            {messages.map((msg) => (
              <View
                key={msg.id}
                style={[
                  styles.messageBubble,
                  msg.role === 'user'
                    ? styles.userBubble
                    : styles.assistantBubble,
                ]}
              >
                {msg.role === 'assistant' && (
                  <View style={styles.botAvatar}>
                    <Ionicons name="hardware-chip" size={14} color="#00d4ff" />
                  </View>
                )}
                <View
                  style={[
                    styles.bubbleContent,
                    msg.role === 'user'
                      ? styles.userBubbleContent
                      : styles.assistantBubbleContent,
                  ]}
                >
                  <Text
                    style={[
                      styles.bubbleText,
                      msg.role === 'user' && styles.userBubbleText,
                    ]}
                  >
                    {msg.content}
                  </Text>
                </View>
              </View>
            ))}
          </ScrollView>

          <View style={styles.inputRow}>
            <TextInput
              style={styles.chatInput}
              value={inputText}
              onChangeText={setInputText}
              placeholder="Type your question..."
              placeholderTextColor="#4a4a5a"
              onSubmitEditing={sendMessage}
              returnKeyType="send"
            />
            <TouchableOpacity
              style={[styles.sendButton, !inputText.trim() && styles.sendButtonDisabled]}
              onPress={sendMessage}
              disabled={!inputText.trim()}
            >
              <Ionicons name="send" size={18} color="#0a0a0f" />
            </TouchableOpacity>
          </View>
        </View>
      )}

      {/* FAQ tab */}
      {activeTab === 'faq' && (
        <ScrollView
          style={styles.faqContainer}
          showsVerticalScrollIndicator={false}
          contentContainerStyle={styles.faqContent}
        >
          <Text style={styles.faqTitle}>Frequently Asked Questions</Text>
          {FAQ_DATA.map((faq) => (
            <Card key={faq.id} style={styles.faqCard}>
              <TouchableOpacity
                onPress={() =>
                  setExpandedFAQ(expandedFAQ === faq.id ? null : faq.id)
                }
              >
                <View style={styles.faqHeader}>
                  <Text style={styles.faqQuestion}>{faq.question}</Text>
                  <Ionicons
                    name={expandedFAQ === faq.id ? 'chevron-up' : 'chevron-down'}
                    size={18}
                    color="#00d4ff"
                  />
                </View>
                {expandedFAQ === faq.id && (
                  <Text style={styles.faqAnswer}>{faq.answer}</Text>
                )}
              </TouchableOpacity>
            </Card>
          ))}

          <View style={styles.contactSection}>
            <Text style={styles.contactTitle}>Still need help?</Text>
            <View style={styles.contactOptions}>
              <TouchableOpacity style={styles.contactOption}>
                <Ionicons name="call" size={22} color="#00d4ff" />
                <Text style={styles.contactLabel}>Call</Text>
                <Text style={styles.contactValue}>400-888-8888</Text>
              </TouchableOpacity>
              <TouchableOpacity style={styles.contactOption}>
                <Ionicons name="mail" size={22} color="#00d4ff" />
                <Text style={styles.contactLabel}>Email</Text>
                <Text style={styles.contactValue}>support@starmotor.com</Text>
              </TouchableOpacity>
            </View>
          </View>
        </ScrollView>
      )}

      {/* Ticket tab */}
      {activeTab === 'ticket' && (
        <ScrollView
          style={styles.ticketContainer}
          showsVerticalScrollIndicator={false}
          contentContainerStyle={styles.ticketContent}
        >
          <Text style={styles.ticketTitle}>Create Support Ticket</Text>
          <Text style={styles.ticketSubtitle}>
            Describe your issue and we'll get back to you within 24 hours.
          </Text>

          <Text style={styles.inputLabel}>Category</Text>
          <View style={styles.categoryGrid}>
            {SUPPORT_CATEGORIES.map((cat) => (
              <TouchableOpacity
                key={cat}
                style={[
                  styles.categoryOption,
                  ticketCategory === cat && styles.categoryOptionActive,
                ]}
                onPress={() => setTicketCategory(cat)}
              >
                <Text
                  style={[
                    styles.categoryOptionText,
                    ticketCategory === cat && styles.categoryOptionTextActive,
                  ]}
                >
                  {cat}
                </Text>
              </TouchableOpacity>
            ))}
          </View>

          <Text style={styles.inputLabel}>Describe your issue</Text>
          <TextInput
            style={styles.descriptionInput}
            value={ticketDescription}
            onChangeText={setTicketDescription}
            placeholder="Please provide as much detail as possible including error messages, steps to reproduce the issue, and any relevant information..."
            placeholderTextColor="#4a4a5a"
            multiline
            numberOfLines={6}
            textAlignVertical="top"
          />

          <Button
            title="Submit Support Ticket"
            onPress={submitTicket}
            fullWidth
            size="large"
            style={{ marginTop: 16 }}
          />
        </ScrollView>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0a0a0f',
  },
  tabRow: {
    flexDirection: 'row',
    marginHorizontal: 16,
    marginVertical: 10,
    backgroundColor: '#12121f',
    borderRadius: 12,
    padding: 4,
    borderWidth: 1,
    borderColor: '#1e1e35',
  },
  tab: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 5,
    paddingVertical: 9,
    borderRadius: 9,
  },
  tabActive: {
    backgroundColor: '#00d4ff',
  },
  tabText: {
    color: '#6a6a7a',
    fontSize: 13,
    fontWeight: '600',
  },
  tabTextActive: {
    color: '#0a0a0f',
    fontWeight: '700',
  },
  // Chat styles
  chatContainer: {
    flex: 1,
  },
  messageList: {
    flex: 1,
  },
  messageListContent: {
    padding: 16,
    paddingBottom: 8,
  },
  messageBubble: {
    flexDirection: 'row',
    marginBottom: 12,
    alignItems: 'flex-end',
  },
  userBubble: {
    justifyContent: 'flex-end',
  },
  assistantBubble: {
    justifyContent: 'flex-start',
  },
  botAvatar: {
    width: 28,
    height: 28,
    borderRadius: 14,
    backgroundColor: '#0d1a2e',
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 8,
    borderWidth: 1,
    borderColor: '#00d4ff33',
  },
  bubbleContent: {
    maxWidth: '75%',
    borderRadius: 16,
    padding: 12,
  },
  userBubbleContent: {
    backgroundColor: '#00d4ff',
    borderBottomRightRadius: 4,
  },
  assistantBubbleContent: {
    backgroundColor: '#12121f',
    borderBottomLeftRadius: 4,
    borderWidth: 1,
    borderColor: '#1e1e35',
  },
  bubbleText: {
    color: '#ffffff',
    fontSize: 14,
    lineHeight: 20,
  },
  userBubbleText: {
    color: '#0a0a0f',
  },
  inputRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
    padding: 12,
    paddingBottom: 16,
    borderTopWidth: 1,
    borderTopColor: '#1e1e35',
    backgroundColor: '#0a0a0f',
  },
  chatInput: {
    flex: 1,
    backgroundColor: '#12121f',
    borderRadius: 24,
    borderWidth: 1,
    borderColor: '#2a2a3e',
    color: '#ffffff',
    fontSize: 14,
    paddingHorizontal: 16,
    paddingVertical: 11,
  },
  sendButton: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: '#00d4ff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  sendButtonDisabled: {
    backgroundColor: '#1e1e35',
  },
  // FAQ styles
  faqContainer: {
    flex: 1,
  },
  faqContent: {
    padding: 16,
  },
  faqTitle: {
    color: '#ffffff',
    fontSize: 18,
    fontWeight: '700',
    marginBottom: 16,
  },
  faqCard: {
    marginBottom: 10,
  },
  faqHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  faqQuestion: {
    flex: 1,
    color: '#ffffff',
    fontSize: 15,
    fontWeight: '600',
    paddingRight: 10,
  },
  faqAnswer: {
    color: '#8a8a9a',
    fontSize: 14,
    lineHeight: 20,
    marginTop: 12,
    paddingTop: 12,
    borderTopWidth: 1,
    borderTopColor: '#1e1e35',
  },
  contactSection: {
    marginTop: 24,
  },
  contactTitle: {
    color: '#ffffff',
    fontSize: 17,
    fontWeight: '700',
    marginBottom: 14,
  },
  contactOptions: {
    flexDirection: 'row',
    gap: 12,
  },
  contactOption: {
    flex: 1,
    backgroundColor: '#12121f',
    borderRadius: 12,
    padding: 16,
    alignItems: 'center',
    gap: 6,
    borderWidth: 1,
    borderColor: '#1e1e35',
  },
  contactLabel: {
    color: '#8a8a9a',
    fontSize: 12,
  },
  contactValue: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '600',
    textAlign: 'center',
  },
  // Ticket styles
  ticketContainer: {
    flex: 1,
  },
  ticketContent: {
    padding: 16,
  },
  ticketTitle: {
    color: '#ffffff',
    fontSize: 18,
    fontWeight: '700',
    marginBottom: 6,
  },
  ticketSubtitle: {
    color: '#6a6a7a',
    fontSize: 13,
    marginBottom: 20,
    lineHeight: 18,
  },
  inputLabel: {
    color: '#8a8a9a',
    fontSize: 13,
    fontWeight: '600',
    marginBottom: 10,
  },
  categoryGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
    marginBottom: 20,
  },
  categoryOption: {
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#2a2a3e',
    backgroundColor: '#12121f',
  },
  categoryOptionActive: {
    backgroundColor: '#001f2e',
    borderColor: '#00d4ff',
  },
  categoryOptionText: {
    color: '#6a6a7a',
    fontSize: 13,
    fontWeight: '600',
  },
  categoryOptionTextActive: {
    color: '#00d4ff',
  },
  descriptionInput: {
    backgroundColor: '#12121f',
    borderRadius: 12,
    borderWidth: 1,
    borderColor: '#2a2a3e',
    color: '#ffffff',
    fontSize: 14,
    padding: 14,
    height: 160,
    textAlignVertical: 'top',
    lineHeight: 20,
  },
});

export default CustomerServiceScreen;
