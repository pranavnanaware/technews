import React from 'react';
import { View, Text, TouchableOpacity } from 'react-native';
import { router } from 'expo-router';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';

export default function ProfileScreen() {
  return (
    <SafeAreaView className="flex-1 bg-white">
      <View className="flex-1 justify-center items-center px-6">
        <View className="w-20 h-20 bg-primary-100 rounded-full items-center justify-center mb-6">
          <Ionicons name="person-outline" size={40} color="#0284c7" />
        </View>
        <Text className="text-2xl font-inter-bold text-gray-900 text-center mb-3">
          Profile
        </Text>
        <Text className="text-base font-inter text-gray-600 text-center mb-8">
          Manage your account and preferences
        </Text>
        
        <TouchableOpacity
          className="bg-primary-600 rounded-2xl py-3 px-6 mb-4"
          onPress={() => router.push('/subscription')}
        >
          <Text className="text-white text-base font-inter-semibold">
            Upgrade to Premium
          </Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
}