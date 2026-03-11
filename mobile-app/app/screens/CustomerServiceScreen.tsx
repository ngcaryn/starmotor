import React, { useState, useRef } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, TextInput, FlatList, KeyboardAvoidingView, Platform } from 'react-native';
import Header from '../components/Header';
import Card from '../components/Card';
import Colors from '../theme/colors';

interface Message { id: string; from: 'user' | 'bot'; text: string; time: string; }

const BOT_RESPONSES: Record<string, string> = {
  default: "Thank you for reaching out. A support agent will respond within 2 hours. For urgent issues, call +86 400-STAR-001.",
  warranty: "StarMotor vehicles are covered by an 8-year/160,000 km battery warranty and a 4-year/80,000 km comprehensive warranty.",
  service: "You can book a service appointment via the app under Profile → Service Appointments, or call your nearest service center.",
  charging: "StarMotor supports CCS2, CHAdeMO, and Type 2 charging. DC fast charging (250 kW) takes approximately 18 minutes for 80%.",
  delivery: "Standard delivery takes 4–8 weeks from order confirmation. You can track your order status under Profile → My Orders.",
};

const FAQ = [
  { id: 'f1', question: 'What is the warranty coverage?', key: 'warranty' },
  { id: 'f2', question: 'How do I book a service?', key: 'service' },
  { id: 'f3', question: 'What charging standards are supported?', key: 'charging' },
  { id: 'f4', question: 'When will my vehicle be delivered?', key: 'delivery' },
];

const now = () => new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

const CustomerServiceScreen: React.FC<{ navigation: any }> = ({ navigation }) => {
  const [tab, setTab] = useState<'chat' | 'faq' | 'ticket'>('chat');
  const [messages, setMessages] = useState<Message[]>([
    { id: '0', from: 'bot', text: 'Hello! I\'m the StarMotor assistant. How can I help you today?', time: now() },
  ]);
  const [input, setInput] = useState('');
  const [ticketSubject, setTicketSubject] = useState('');
  const [ticketBody, setTicketBody] = useState('');

  const sendMessage = (text?: string) => {
    const msg = (text ?? input).trim();
    if (!msg) return;
    const userMsg: Message = { id: Date.now().toString(), from: 'user', text: msg, time: now() };
    const keyword = Object.keys(BOT_RESPONSES).find((k) => msg.toLowerCase().includes(k)) ?? 'default';
    const botMsg: Message = { id: (Date.now() + 1).toString(), from: 'bot', text: BOT_RESPONSES[keyword], time: now() };
    setMessages((prev) => [...prev, userMsg, botMsg]);
    setInput('');
  };

  const submitTicket = () => {
    if (!ticketSubject.trim() || !ticketBody.trim()) return;
    setTicketSubject(''); setTicketBody('');
    setTab('chat');
    setMessages((prev) => [...prev, { id: Date.now().toString(), from: 'bot', text: `Support ticket created: "${ticketSubject}". Our team will respond within 24 hours.`, time: now() }]);
  };

  return (
    <View style={styles.container}>
      <Header title="Support" showBack onBack={() => navigation.goBack()} />
      <View style={styles.tabRow}>
        {(['chat', 'faq', 'ticket'] as const).map((t) => (
          <TouchableOpacity key={t} style={[styles.tab, tab === t && styles.tabActive]} onPress={() => setTab(t)}>
            <Text style={[styles.tabText, tab === t && styles.tabTextActive]}>
              {t === 'chat' ? 'Chat' : t === 'faq' ? 'FAQ' : 'Ticket'}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      {tab === 'chat' && (
        <KeyboardAvoidingView style={{ flex: 1 }} behavior={Platform.OS === 'ios' ? 'padding' : undefined}>
          <FlatList
            data={messages} keyExtractor={(item) => item.id}
            renderItem={({ item }) => (
              <View style={[styles.bubble, item.from === 'user' ? styles.bubbleUser : styles.bubbleBot]}>
                <Text style={[styles.bubbleText, item.from === 'user' && styles.bubbleTextUser]}>{item.text}</Text>
                <Text style={styles.bubbleTime}>{item.time}</Text>
              </View>
            )}
            contentContainerStyle={styles.chatContent}
          />
          <View style={styles.chatInput}>
            <TextInput style={styles.chatTextInput} value={input} onChangeText={setInput} placeholder="Type a message..." placeholderTextColor={Colors.textDim} onSubmitEditing={() => sendMessage()} />
            <TouchableOpacity style={styles.sendButton} onPress={() => sendMessage()}>
              <Text style={styles.sendText}>Send</Text>
            </TouchableOpacity>
          </View>
        </KeyboardAvoidingView>
      )}

      {tab === 'faq' && (
        <ScrollView contentContainerStyle={styles.faqContent}>
          {FAQ.map((item) => (
            <TouchableOpacity key={item.id} style={styles.faqItem} onPress={() => { setTab('chat'); sendMessage(item.question); }}>
              <Text style={styles.faqQuestion}>{item.question}</Text>
              <Text style={styles.faqArrow}>›</Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      )}

      {tab === 'ticket' && (
        <ScrollView contentContainerStyle={styles.ticketContent}>
          <Text style={styles.fieldLabel}>SUBJECT</Text>
          <TextInput style={styles.fieldInput} value={ticketSubject} onChangeText={setTicketSubject} placeholder="Brief description" placeholderTextColor={Colors.textDim} />
          <Text style={styles.fieldLabel}>DETAILS</Text>
          <TextInput style={[styles.fieldInput, styles.fieldTextArea]} value={ticketBody} onChangeText={setTicketBody} placeholder="Provide as much detail as possible..." placeholderTextColor={Colors.textDim} multiline numberOfLines={5} />
          <TouchableOpacity style={[styles.submitButton, (!ticketSubject || !ticketBody) && styles.submitDisabled]} onPress={submitTicket}>
            <Text style={styles.submitText}>Submit Ticket</Text>
          </TouchableOpacity>
        </ScrollView>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: Colors.bgPrimary },
  tabRow: { flexDirection: 'row', borderBottomWidth: 1, borderBottomColor: Colors.borderDark },
  tab: { flex: 1, paddingVertical: 12, alignItems: 'center' },
  tabActive: { borderBottomWidth: 2, borderBottomColor: Colors.accent },
  tabText: { color: Colors.textSecondary, fontSize: 13, fontWeight: '500' },
  tabTextActive: { color: Colors.accent },
  chatContent: { padding: 16 },
  bubble: { maxWidth: '80%', borderRadius: 8, padding: 12, marginBottom: 8 },
  bubbleBot: { backgroundColor: Colors.bgCard, borderWidth: 1, borderColor: Colors.border, alignSelf: 'flex-start' },
  bubbleUser: { backgroundColor: Colors.bgElevated, borderWidth: 1, borderColor: Colors.borderActive, alignSelf: 'flex-end' },
  bubbleText: { color: Colors.textPrimary, fontSize: 14, lineHeight: 20, marginBottom: 4 },
  bubbleTextUser: { color: Colors.accentBright },
  bubbleTime: { color: Colors.textDim, fontSize: 10, textAlign: 'right' },
  chatInput: { flexDirection: 'row', padding: 12, borderTopWidth: 1, borderTopColor: Colors.borderDark, gap: 8 },
  chatTextInput: { flex: 1, backgroundColor: Colors.bgCard, borderRadius: 6, borderWidth: 1, borderColor: Colors.border, color: Colors.textPrimary, fontSize: 14, paddingHorizontal: 12, paddingVertical: 9 },
  sendButton: { backgroundColor: Colors.accent, borderRadius: 6, paddingHorizontal: 16, justifyContent: 'center' },
  sendText: { color: Colors.bgPrimary, fontSize: 13, fontWeight: '600' },
  faqContent: { padding: 16 },
  faqItem: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', paddingVertical: 14, borderBottomWidth: 1, borderBottomColor: Colors.borderDark },
  faqQuestion: { color: Colors.textPrimary, fontSize: 14, fontWeight: '500', flex: 1 },
  faqArrow: { color: Colors.accentDim, fontSize: 22, fontWeight: '300', paddingLeft: 8 },
  ticketContent: { padding: 16 },
  fieldLabel: { color: Colors.textDim, fontSize: 10, fontWeight: '600', letterSpacing: 1.5, marginBottom: 6, marginTop: 12 },
  fieldInput: { backgroundColor: Colors.bgCard, borderRadius: 6, borderWidth: 1, borderColor: Colors.border, color: Colors.textPrimary, fontSize: 14, paddingHorizontal: 12, paddingVertical: 11 },
  fieldTextArea: { height: 120, textAlignVertical: 'top' },
  submitButton: { backgroundColor: Colors.accent, borderRadius: 6, padding: 14, alignItems: 'center', marginTop: 20 },
  submitDisabled: { opacity: 0.5 },
  submitText: { color: Colors.bgPrimary, fontSize: 14, fontWeight: '600' },
});

export default CustomerServiceScreen;
