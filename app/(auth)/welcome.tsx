import React, { useEffect } from 'react';
import { View, Text, TouchableOpacity, Dimensions } from 'react-native';
import { router } from 'expo-router';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
  withDelay,
  withSpring,
} from 'react-native-reanimated';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { SafeAreaView } from 'react-native-safe-area-context';

const { width, height } = Dimensions.get('window');

export default function WelcomeScreen() {
  const titleOpacity = useSharedValue(0);
  const subtitleOpacity = useSharedValue(0);
  const buttonsTranslateY = useSharedValue(50);
  const buttonsOpacity = useSharedValue(0);
  const logoScale = useSharedValue(0.8);

  useEffect(() => {
    // Staggered animation entrance
    logoScale.value = withSpring(1, { damping: 10, stiffness: 100 });
    titleOpacity.value = withDelay(200, withTiming(1, { duration: 600 }));
    subtitleOpacity.value = withDelay(400, withTiming(1, { duration: 600 }));
    
    buttonsTranslateY.value = withDelay(600, withSpring(0, { damping: 15, stiffness: 100 }));
    buttonsOpacity.value = withDelay(600, withTiming(1, { duration: 500 }));
  }, []);

  const titleAnimatedStyle = useAnimatedStyle(() => ({
    opacity: titleOpacity.value,
  }));

  const subtitleAnimatedStyle = useAnimatedStyle(() => ({
    opacity: subtitleOpacity.value,
  }));

  const buttonsAnimatedStyle = useAnimatedStyle(() => ({
    transform: [{ translateY: buttonsTranslateY.value }],
    opacity: buttonsOpacity.value,
  }));

  const logoAnimatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: logoScale.value }],
  }));

  return (
    <SafeAreaView className="flex-1 bg-white">
      <LinearGradient
        colors={['#ffffff', '#f8fafc', '#f0f9ff']}
        className="flex-1"
      >
        <View className="flex-1 px-6">
          {/* Header Section */}
          <View className="flex-1 justify-center items-center">
            <Animated.View style={logoAnimatedStyle} className="items-center mb-8">
              <View className="w-24 h-24 bg-primary-600 rounded-3xl items-center justify-center mb-6 shadow-lg">
                <Ionicons name="newspaper-outline" size={48} color="white" />
              </View>
            </Animated.View>

            <Animated.View style={titleAnimatedStyle} className="items-center mb-4">
              <Text className="text-4xl font-inter-bold text-gray-900 text-center mb-2">
                Welcome to
              </Text>
              <Text className="text-4xl font-inter-bold text-primary-600 text-center">
                TechNews
              </Text>
            </Animated.View>

            <Animated.View style={subtitleAnimatedStyle} className="items-center mb-12">
              <Text className="text-lg font-inter text-gray-600 text-center leading-relaxed px-4">
                Discover the latest in technology with personalized news and insights
              </Text>
            </Animated.View>
          </View>

          {/* Action Buttons */}
          <Animated.View style={buttonsAnimatedStyle} className="pb-8">
            {/* Apple Sign In */}
            <TouchableOpacity 
              className="bg-black rounded-2xl py-4 px-6 mb-4 flex-row items-center justify-center shadow-sm"
              onPress={() => console.log('Apple Sign In')}
            >
              <Ionicons name="logo-apple" size={24} color="white" />
              <Text className="text-white text-lg font-inter-semibold ml-3">
                Continue with Apple
              </Text>
            </TouchableOpacity>

            {/* Google Sign In */}
            <TouchableOpacity 
              className="bg-white border border-gray-300 rounded-2xl py-4 px-6 mb-4 flex-row items-center justify-center shadow-sm"
              onPress={() => console.log('Google Sign In')}
            >
              <Ionicons name="logo-google" size={24} color="#4285F4" />
              <Text className="text-gray-900 text-lg font-inter-semibold ml-3">
                Continue with Google
              </Text>
            </TouchableOpacity>

            {/* Email Sign In */}
            <TouchableOpacity 
              className="bg-primary-600 rounded-2xl py-4 px-6 mb-6 flex-row items-center justify-center shadow-sm"
              onPress={() => router.push('/(auth)/login')}
            >
              <Ionicons name="mail-outline" size={24} color="white" />
              <Text className="text-white text-lg font-inter-semibold ml-3">
                Continue with Email
              </Text>
            </TouchableOpacity>

            {/* Terms and Privacy */}
            <View className="items-center">
              <Text className="text-sm font-inter text-gray-500 text-center leading-relaxed">
                By continuing, you agree to our{' '}
                <Text className="text-primary-600 font-inter-medium">Terms of Service</Text>
                {' '}and{' '}
                <Text className="text-primary-600 font-inter-medium">Privacy Policy</Text>
              </Text>
            </View>
          </Animated.View>
        </View>
      </LinearGradient>
    </SafeAreaView>
  );
}