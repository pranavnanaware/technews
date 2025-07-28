import React from 'react';
import { View, Text } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';

export default function BookmarksScreen() {
  return (
    <SafeAreaView className="flex-1 bg-white">
      <View className="flex-1 justify-center items-center px-6">
        <View className="w-20 h-20 bg-primary-100 rounded-full items-center justify-center mb-6">
          <Ionicons name="bookmark-outline" size={40} color="#0284c7" />
        </View>
        <Text className="text-2xl font-inter-bold text-gray-900 text-center mb-3">
          Bookmarks
        </Text>
        <Text className="text-base font-inter text-gray-600 text-center">
          Your saved articles and stories
        </Text>
      </View>
    </SafeAreaView>
  );
}