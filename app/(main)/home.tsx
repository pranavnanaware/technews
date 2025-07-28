import React, { useEffect } from 'react';
import { View, Text, ScrollView, TouchableOpacity, Image } from 'react-native';
import { router } from 'expo-router';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
  withDelay,
} from 'react-native-reanimated';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { SafeAreaView } from 'react-native-safe-area-context';

// Mock data for demonstration
const mockNews = [
  {
    id: 1,
    title: 'Apple Announces Revolutionary New M4 Chip Architecture',
    summary: 'The new M4 chip promises 40% better performance and improved AI capabilities.',
    category: 'Hardware',
    readTime: '3 min read',
    publishedAt: '2 hours ago',
    image: 'https://picsum.photos/400/200?random=1',
    isPremium: false,
  },
  {
    id: 2,
    title: 'Meta\'s Latest VR Breakthrough Changes Everything',
    summary: 'New haptic technology brings unprecedented realism to virtual experiences.',
    category: 'VR/AR',
    readTime: '5 min read',
    publishedAt: '4 hours ago',
    image: 'https://picsum.photos/400/200?random=2',
    isPremium: true,
  },
  {
    id: 3,
    title: 'OpenAI GPT-5 Beta Testing Begins',
    summary: 'Early reports suggest massive improvements in reasoning and creativity.',
    category: 'AI',
    readTime: '4 min read',
    publishedAt: '6 hours ago',
    image: 'https://picsum.photos/400/200?random=3',
    isPremium: true,
  },
];

export default function HomeScreen() {
  const headerOpacity = useSharedValue(0);
  const contentOpacity = useSharedValue(0);

  useEffect(() => {
    headerOpacity.value = withTiming(1, { duration: 600 });
    contentOpacity.value = withDelay(200, withTiming(1, { duration: 500 }));
  }, []);

  const headerAnimatedStyle = useAnimatedStyle(() => ({
    opacity: headerOpacity.value,
  }));

  const contentAnimatedStyle = useAnimatedStyle(() => ({
    opacity: contentOpacity.value,
  }));

  const renderNewsCard = (article: any, index: number) => (
    <TouchableOpacity
      key={article.id}
      className="bg-white rounded-2xl mb-4 shadow-sm border border-gray-100"
      onPress={() => console.log('Open article:', article.title)}
    >
      <View className="relative">
        <Image
          source={{ uri: article.image }}
          className="w-full h-48 rounded-t-2xl"
          resizeMode="cover"
        />
        {article.isPremium && (
          <View className="absolute top-3 right-3 bg-yellow-500 px-2 py-1 rounded-full">
            <Text className="text-white text-xs font-inter-semibold">Premium</Text>
          </View>
        )}
        <View className="absolute top-3 left-3 bg-black/20 backdrop-blur-sm px-3 py-1 rounded-full">
          <Text className="text-white text-xs font-inter-medium">{article.category}</Text>
        </View>
      </View>
      
      <View className="p-4">
        <Text className="text-lg font-inter-semibold text-gray-900 mb-2 leading-6">
          {article.title}
        </Text>
        <Text className="text-sm font-inter text-gray-600 mb-4 leading-5">
          {article.summary}
        </Text>
        
        <View className="flex-row items-center justify-between">
          <View className="flex-row items-center">
            <Text className="text-xs font-inter text-gray-500 mr-3">
              {article.readTime}
            </Text>
            <Text className="text-xs font-inter text-gray-500">
              {article.publishedAt}
            </Text>
          </View>
          
          <View className="flex-row items-center space-x-3">
            <TouchableOpacity className="w-8 h-8 items-center justify-center">
              <Ionicons name="bookmark-outline" size={18} color="#64748b" />
            </TouchableOpacity>
            <TouchableOpacity className="w-8 h-8 items-center justify-center">
              <Ionicons name="share-outline" size={18} color="#64748b" />
            </TouchableOpacity>
          </View>
        </View>
      </View>
    </TouchableOpacity>
  );

  return (
    <SafeAreaView className="flex-1 bg-gray-50">
      <LinearGradient
        colors={['#ffffff', '#f8fafc']}
        className="flex-1"
      >
        {/* Header */}
        <Animated.View style={headerAnimatedStyle} className="px-6 py-4">
          <View className="flex-row items-center justify-between mb-4">
            <View>
              <Text className="text-2xl font-inter-bold text-gray-900">
                Good morning! 👋
              </Text>
              <Text className="text-base font-inter text-gray-600">
                Here's your daily tech digest
              </Text>
            </View>
            
            <View className="flex-row items-center space-x-3">
              <TouchableOpacity className="w-10 h-10 bg-white rounded-full items-center justify-center shadow-sm">
                <Ionicons name="search-outline" size={20} color="#374151" />
              </TouchableOpacity>
              <TouchableOpacity 
                className="w-10 h-10 bg-white rounded-full items-center justify-center shadow-sm"
                onPress={() => router.push('/subscription')}
              >
                <Ionicons name="diamond-outline" size={20} color="#374151" />
              </TouchableOpacity>
            </View>
          </View>
          
          {/* Categories */}
          <ScrollView horizontal showsHorizontalScrollIndicator={false} className="mb-4">
            <View className="flex-row space-x-3">
              {['All', 'AI', 'Hardware', 'Software', 'Startups', 'Mobile'].map((category) => (
                <TouchableOpacity
                  key={category}
                  className={`px-4 py-2 rounded-full ${
                    category === 'All' 
                      ? 'bg-primary-600' 
                      : 'bg-white border border-gray-200'
                  }`}
                >
                  <Text className={`text-sm font-inter-medium ${
                    category === 'All' ? 'text-white' : 'text-gray-700'
                  }`}>
                    {category}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>
          </ScrollView>
        </Animated.View>

        {/* News Feed */}
        <Animated.View style={contentAnimatedStyle} className="flex-1">
          <ScrollView className="flex-1 px-6" showsVerticalScrollIndicator={false}>
            {/* Breaking News Banner */}
            <TouchableOpacity className="bg-gradient-to-r from-red-500 to-pink-500 rounded-2xl p-4 mb-6">
              <View className="flex-row items-center">
                <View className="w-2 h-2 bg-white rounded-full mr-2 animate-pulse" />
                <Text className="text-white text-sm font-inter-semibold">BREAKING</Text>
              </View>
              <Text className="text-white text-lg font-inter-bold mt-2">
                Major Security Vulnerability Discovered in Popular Framework
              </Text>
              <Text className="text-white/80 text-sm font-inter mt-1">
                Tap to read the full story
              </Text>
            </TouchableOpacity>

            {/* News Articles */}
            {mockNews.map((article, index) => renderNewsCard(article, index))}
            
            <View className="h-20" />
          </ScrollView>
        </Animated.View>
      </LinearGradient>
    </SafeAreaView>
  );
}