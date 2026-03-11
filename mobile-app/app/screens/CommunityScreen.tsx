import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  FlatList,
  TouchableOpacity,
  TextInput,
  Modal,
  Alert,
  ScrollView,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useSelector } from 'react-redux';
import { RootState } from '../store/store';
import Card from '../components/Card';
import Header from '../components/Header';
import Button from '../components/Button';

interface Post {
  id: string;
  author: string;
  avatar: string;
  title: string;
  content: string;
  category: string;
  likes: number;
  comments: number;
  timestamp: string;
  isLiked: boolean;
}

const MOCK_POSTS: Post[] = [
  {
    id: 'post1',
    author: 'Alex Chen',
    avatar: 'AC',
    title: 'StarX Pro range test - 510 miles achieved!',
    content:
      'Just completed a full range test on the StarX Pro. Managed to squeeze out 510 miles on a single charge driving at 65mph with climate control on. Absolutely incredible engineering! 🚗⚡',
    category: 'Ownership',
    likes: 247,
    comments: 43,
    timestamp: '2h ago',
    isLiked: false,
  },
  {
    id: 'post2',
    author: 'Sarah M.',
    avatar: 'SM',
    title: 'Interior review after 6 months of daily driving',
    content:
      'Six months in with my StarSUV Ultra and I wanted to share my honest impressions. The premium audio system is phenomenal, but I\'ve noticed some minor panel alignment issues...',
    category: 'Review',
    likes: 182,
    comments: 67,
    timestamp: '5h ago',
    isLiked: true,
  },
  {
    id: 'post3',
    author: 'Michael T.',
    avatar: 'MT',
    title: 'StarGT Elite at the track - video highlights',
    content:
      'Took my StarGT Elite to Zhuhai Circuit last weekend. The 2.1 second 0-60 is real – I timed it myself multiple times. The handling is absolutely pinpoint sharp in Sport+.',
    category: 'Performance',
    likes: 423,
    comments: 89,
    timestamp: '1d ago',
    isLiked: false,
  },
  {
    id: 'post4',
    author: 'Jenny Liu',
    avatar: 'JL',
    title: 'Tips for maximizing charging efficiency',
    content:
      'After 8 months of ownership, I\'ve discovered some tips to optimize charging. Pre-conditioning the battery 30 minutes before arrival at a fast charger makes a huge difference!',
    category: 'Tips',
    likes: 311,
    comments: 54,
    timestamp: '2d ago',
    isLiked: false,
  },
];

const CATEGORIES = ['All', 'Ownership', 'Review', 'Performance', 'Tips', 'Events'];

const CommunityScreen: React.FC = () => {
  const { user } = useSelector((state: RootState) => state.auth);
  const [posts, setPosts] = useState<Post[]>(MOCK_POSTS);
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [showCreatePost, setShowCreatePost] = useState(false);
  const [newPostTitle, setNewPostTitle] = useState('');
  const [newPostContent, setNewPostContent] = useState('');

  const filteredPosts =
    selectedCategory === 'All'
      ? posts
      : posts.filter((p) => p.category === selectedCategory);

  const handleLike = (postId: string) => {
    setPosts((prev) =>
      prev.map((p) =>
        p.id === postId
          ? {
              ...p,
              isLiked: !p.isLiked,
              likes: p.isLiked ? p.likes - 1 : p.likes + 1,
            }
          : p
      )
    );
  };

  const handleCreatePost = () => {
    if (!newPostTitle.trim() || !newPostContent.trim()) {
      Alert.alert('Missing Fields', 'Please provide a title and content for your post.');
      return;
    }
    const newPost: Post = {
      id: `post_${Date.now()}`,
      author: user?.name ?? 'Anonymous',
      avatar: (user?.name?.substring(0, 2) ?? 'AN').toUpperCase(),
      title: newPostTitle.trim(),
      content: newPostContent.trim(),
      category: 'General',
      likes: 0,
      comments: 0,
      timestamp: 'Just now',
      isLiked: false,
    };
    setPosts([newPost, ...posts]);
    setNewPostTitle('');
    setNewPostContent('');
    setShowCreatePost(false);
    Alert.alert('Posted!', 'Your post has been published to the community.');
  };

  const renderPost = ({ item }: { item: Post }) => (
    <Card style={styles.postCard}>
      {/* Post header */}
      <View style={styles.postHeader}>
        <View style={styles.avatarCircle}>
          <Text style={styles.avatarText}>{item.avatar}</Text>
        </View>
        <View style={styles.authorInfo}>
          <Text style={styles.authorName}>{item.author}</Text>
          <Text style={styles.postTime}>{item.timestamp}</Text>
        </View>
        <View style={styles.categoryTag}>
          <Text style={styles.categoryTagText}>{item.category}</Text>
        </View>
      </View>

      {/* Post content */}
      <Text style={styles.postTitle}>{item.title}</Text>
      <Text style={styles.postContent} numberOfLines={4}>
        {item.content}
      </Text>

      {/* Post actions */}
      <View style={styles.postActions}>
        <TouchableOpacity
          style={styles.actionButton}
          onPress={() => handleLike(item.id)}
        >
          <Ionicons
            name={item.isLiked ? 'heart' : 'heart-outline'}
            size={18}
            color={item.isLiked ? '#ff4d6d' : '#6a6a7a'}
          />
          <Text
            style={[styles.actionText, item.isLiked && styles.likedText]}
          >
            {item.likes}
          </Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.actionButton}>
          <Ionicons name="chatbubble-outline" size={18} color="#6a6a7a" />
          <Text style={styles.actionText}>{item.comments}</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.actionButton}>
          <Ionicons name="share-social-outline" size={18} color="#6a6a7a" />
          <Text style={styles.actionText}>Share</Text>
        </TouchableOpacity>
      </View>
    </Card>
  );

  return (
    <View style={styles.container}>
      <Header
        title="Community"
        subtitle="Connect with owners"
        rightIcon="add-circle-outline"
        onRightPress={() => setShowCreatePost(true)}
      />

      {/* Category filter */}
      <FlatList
        horizontal
        data={CATEGORIES}
        keyExtractor={(item) => item}
        renderItem={({ item }) => (
          <TouchableOpacity
            style={[
              styles.categoryChip,
              selectedCategory === item && styles.categoryChipActive,
            ]}
            onPress={() => setSelectedCategory(item)}
          >
            <Text
              style={[
                styles.categoryChipText,
                selectedCategory === item && styles.categoryChipTextActive,
              ]}
            >
              {item}
            </Text>
          </TouchableOpacity>
        )}
        contentContainerStyle={styles.categoryContent}
        showsHorizontalScrollIndicator={false}
        style={styles.categoryScroll}
      />

      {/* Post list */}
      <FlatList
        data={filteredPosts}
        keyExtractor={(item) => item.id}
        renderItem={renderPost}
        contentContainerStyle={styles.listContent}
        showsVerticalScrollIndicator={false}
      />

      {/* Create post modal */}
      <Modal
        visible={showCreatePost}
        animationType="slide"
        transparent
        onRequestClose={() => setShowCreatePost(false)}
      >
        <View style={styles.modalOverlay}>
          <View style={styles.modalContent}>
            <View style={styles.modalHeader}>
              <Text style={styles.modalTitle}>Create Post</Text>
              <TouchableOpacity onPress={() => setShowCreatePost(false)}>
                <Ionicons name="close" size={24} color="#8a8a9a" />
              </TouchableOpacity>
            </View>

            <ScrollView>
              <Text style={styles.inputLabel}>Title</Text>
              <TextInput
                style={styles.titleInput}
                value={newPostTitle}
                onChangeText={setNewPostTitle}
                placeholder="Write a compelling title..."
                placeholderTextColor="#4a4a5a"
              />
              <Text style={styles.inputLabel}>Content</Text>
              <TextInput
                style={styles.contentInput}
                value={newPostContent}
                onChangeText={setNewPostContent}
                placeholder="Share your experience, tips, or questions with the community..."
                placeholderTextColor="#4a4a5a"
                multiline
                numberOfLines={6}
                textAlignVertical="top"
              />
              <Button
                title="Publish Post"
                onPress={handleCreatePost}
                fullWidth
                size="large"
                style={{ marginTop: 16 }}
              />
            </ScrollView>
          </View>
        </View>
      </Modal>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#0a0a0f',
  },
  categoryScroll: {
    maxHeight: 52,
  },
  categoryContent: {
    paddingHorizontal: 16,
    paddingVertical: 10,
    gap: 8,
  },
  categoryChip: {
    paddingHorizontal: 14,
    paddingVertical: 6,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: '#2a2a3e',
    backgroundColor: '#12121f',
    marginRight: 8,
  },
  categoryChipActive: {
    backgroundColor: '#00d4ff',
    borderColor: '#00d4ff',
  },
  categoryChipText: {
    color: '#8a8a9a',
    fontSize: 13,
    fontWeight: '600',
  },
  categoryChipTextActive: {
    color: '#0a0a0f',
  },
  listContent: {
    padding: 16,
  },
  postCard: {
    marginBottom: 12,
  },
  postHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  avatarCircle: {
    width: 38,
    height: 38,
    borderRadius: 19,
    backgroundColor: '#001f2e',
    borderWidth: 1.5,
    borderColor: '#00d4ff',
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 10,
  },
  avatarText: {
    color: '#00d4ff',
    fontSize: 13,
    fontWeight: '700',
  },
  authorInfo: {
    flex: 1,
  },
  authorName: {
    color: '#ffffff',
    fontSize: 14,
    fontWeight: '700',
  },
  postTime: {
    color: '#4a4a5a',
    fontSize: 12,
  },
  categoryTag: {
    backgroundColor: '#0d1a2e',
    borderRadius: 6,
    paddingHorizontal: 8,
    paddingVertical: 3,
    borderWidth: 1,
    borderColor: '#00d4ff33',
  },
  categoryTagText: {
    color: '#00d4ff',
    fontSize: 10,
    fontWeight: '700',
  },
  postTitle: {
    color: '#ffffff',
    fontSize: 16,
    fontWeight: '700',
    marginBottom: 8,
    lineHeight: 22,
  },
  postContent: {
    color: '#8a8a9a',
    fontSize: 14,
    lineHeight: 20,
    marginBottom: 14,
  },
  postActions: {
    flexDirection: 'row',
    gap: 20,
    borderTopWidth: 1,
    borderTopColor: '#1e1e35',
    paddingTop: 12,
  },
  actionButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 5,
  },
  actionText: {
    color: '#6a6a7a',
    fontSize: 13,
    fontWeight: '600',
  },
  likedText: {
    color: '#ff4d6d',
  },
  // Modal styles
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.75)',
    justifyContent: 'flex-end',
  },
  modalContent: {
    backgroundColor: '#12121f',
    borderTopLeftRadius: 24,
    borderTopRightRadius: 24,
    padding: 24,
    maxHeight: '85%',
    borderTopWidth: 1,
    borderColor: '#1e1e35',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 20,
  },
  modalTitle: {
    color: '#ffffff',
    fontSize: 20,
    fontWeight: '700',
  },
  inputLabel: {
    color: '#8a8a9a',
    fontSize: 13,
    fontWeight: '600',
    marginBottom: 8,
  },
  titleInput: {
    backgroundColor: '#0d0d1a',
    borderRadius: 10,
    borderWidth: 1,
    borderColor: '#2a2a3e',
    color: '#ffffff',
    fontSize: 15,
    paddingHorizontal: 14,
    paddingVertical: 12,
    marginBottom: 16,
  },
  contentInput: {
    backgroundColor: '#0d0d1a',
    borderRadius: 10,
    borderWidth: 1,
    borderColor: '#2a2a3e',
    color: '#ffffff',
    fontSize: 15,
    paddingHorizontal: 14,
    paddingVertical: 12,
    height: 150,
    textAlignVertical: 'top',
  },
});

export default CommunityScreen;
