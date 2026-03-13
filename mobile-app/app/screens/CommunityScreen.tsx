import React, { useState } from 'react';
import { View, Text, StyleSheet, FlatList, TouchableOpacity, TextInput, Alert } from 'react-native';
import Card from '../components/Card';
import Header from '../components/Header';
import Button from '../components/Button';
import Colors from '../theme/colors';

interface Post { id: string; author: string; title: string; content: string; likes: number; comments: number; time: string; liked: boolean; tag: string; }

const MOCK_POSTS: Post[] = [
  { id: '1', author: 'Ethan V.', title: 'StarX Pro after 10,000 miles — honest review', content: 'Just hit the 10k mark. Range has been consistent, no degradation detected. The OTA update last month improved regenerative braking noticeably...', likes: 142, comments: 38, time: '2h ago', liked: false, tag: 'REVIEW' },
  { id: '2', author: 'Sara L.', title: 'Best charging stops — Beijing to Shanghai', content: 'Planned a 1,200 km road trip. Here are the top charging stops with wait times and amenities, updated for 2025...', likes: 87, comments: 24, time: '5h ago', liked: true, tag: 'GUIDE' },
  { id: '3', author: 'Marcus T.', title: 'StarGT Elite 0–200 mph run at Zhuhai', content: 'Track day footage and data from our GPS logger. Peak 1,012 hp run with full launch control. Data in the comments...', likes: 311, comments: 62, time: '1d ago', liked: false, tag: 'PERFORMANCE' },
  { id: '4', author: 'Lin H.', title: 'How I customized my StarSUV interior', content: 'Full breakdown of the matte metallic trim swap, ambient lighting upgrade, and custom floor mats...', likes: 56, comments: 19, time: '2d ago', liked: false, tag: 'MOD' },
];

const CommunityScreen: React.FC<{ navigation: any }> = () => {
  const [posts, setPosts] = useState(MOCK_POSTS);
  const [showNewPost, setShowNewPost] = useState(false);
  const [newTitle, setNewTitle] = useState('');
  const [newContent, setNewContent] = useState('');

  const toggleLike = (id: string) => {
    setPosts((prev) => prev.map((p) => p.id === id ? { ...p, liked: !p.liked, likes: p.liked ? p.likes - 1 : p.likes + 1 } : p));
  };

  const submitPost = () => {
    if (!newTitle.trim() || !newContent.trim()) { Alert.alert('Required', 'Title and content are required.'); return; }
    const newPost: Post = { id: Date.now().toString(), author: 'You', title: newTitle.trim(), content: newContent.trim(), likes: 0, comments: 0, time: 'Just now', liked: false, tag: 'DISCUSSION' };
    setPosts([newPost, ...posts]);
    setNewTitle(''); setNewContent(''); setShowNewPost(false);
  };

  return (
    <View style={styles.container}>
      <Header title="Community" subtitle="Discussions" rightLabel="Post" onRightPress={() => setShowNewPost(!showNewPost)} />
      {showNewPost && (
        <View style={styles.newPostForm}>
          <TextInput style={styles.newPostTitle} value={newTitle} onChangeText={setNewTitle} placeholder="Post title" placeholderTextColor={Colors.textDim} />
          <TextInput style={styles.newPostContent} value={newContent} onChangeText={setNewContent} placeholder="Share your thoughts..." placeholderTextColor={Colors.textDim} multiline numberOfLines={3} />
          <View style={styles.newPostActions}>
            <Button title="Publish" onPress={submitPost} size="small" />
            <Button title="Cancel" onPress={() => setShowNewPost(false)} variant="ghost" size="small" />
          </View>
        </View>
      )}
      <FlatList
        data={posts} keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <Card style={styles.postCard}>
            <View style={styles.postHeader}>
              <View style={styles.postTag}><Text style={styles.postTagText}>{item.tag}</Text></View>
              <Text style={styles.postTime}>{item.time}</Text>
            </View>
            <Text style={styles.postTitle}>{item.title}</Text>
            <Text style={styles.postAuthor}>{item.author}</Text>
            <Text style={styles.postContent} numberOfLines={2}>{item.content}</Text>
            <View style={styles.postFooter}>
              <TouchableOpacity onPress={() => toggleLike(item.id)} style={styles.footerAction}>
                <Text style={[styles.footerActionText, item.liked && styles.footerActionActive]}>
                  {item.liked ? '♥' : '♡'}  {item.likes}
                </Text>
              </TouchableOpacity>
              <View style={styles.footerAction}>
                <Text style={styles.footerActionText}>· · ·  {item.comments}</Text>
              </View>
            </View>
          </Card>
        )}
        contentContainerStyle={styles.listContent} showsVerticalScrollIndicator={false}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: Colors.bgPrimary },
  listContent: { padding: 16 },
  newPostForm: { backgroundColor: Colors.bgCard, borderBottomWidth: 1, borderBottomColor: Colors.border, padding: 16 },
  newPostTitle: { backgroundColor: Colors.bgInset, borderRadius: 6, borderWidth: 1, borderColor: Colors.border, color: Colors.textPrimary, fontSize: 14, paddingHorizontal: 12, paddingVertical: 10, marginBottom: 8 },
  newPostContent: { backgroundColor: Colors.bgInset, borderRadius: 6, borderWidth: 1, borderColor: Colors.border, color: Colors.textPrimary, fontSize: 14, paddingHorizontal: 12, paddingVertical: 10, height: 80, textAlignVertical: 'top', marginBottom: 8 },
  newPostActions: { flexDirection: 'row', gap: 8 },
  postCard: { marginBottom: 8 },
  postHeader: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 6 },
  postTag: { backgroundColor: Colors.bgInset, borderRadius: 3, paddingHorizontal: 7, paddingVertical: 2, borderWidth: 1, borderColor: Colors.borderDark },
  postTagText: { color: Colors.accentDim, fontSize: 9, fontWeight: '600', letterSpacing: 1 },
  postTime: { color: Colors.textDim, fontSize: 11 },
  postTitle: { color: Colors.textPrimary, fontSize: 15, fontWeight: '600', marginBottom: 3 },
  postAuthor: { color: Colors.accentDim, fontSize: 11, fontWeight: '500', marginBottom: 6 },
  postContent: { color: Colors.textSecondary, fontSize: 13, lineHeight: 19, marginBottom: 12 },
  postFooter: { flexDirection: 'row', gap: 16 },
  footerAction: { flexDirection: 'row', alignItems: 'center' },
  footerActionText: { color: Colors.textSecondary, fontSize: 13 },
  footerActionActive: { color: Colors.danger },
});

export default CommunityScreen;
