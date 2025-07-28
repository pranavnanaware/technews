import React, { useEffect } from 'react';
import { View, Text } from 'react-native';
import { router } from 'expo-router';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
  withSequence,
  withDelay,
  runOnJS,
} from 'react-native-reanimated';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';

export default function SplashScreen() {
  const logoScale = useSharedValue(0);
  const logoOpacity = useSharedValue(0);
  const textOpacity = useSharedValue(0);
  const gradientOpacity = useSharedValue(0);

  const navigateToAuth = () => {
    router.replace('/(auth)/welcome');
  };

  useEffect(() => {
    // Start animation sequence
    gradientOpacity.value = withTiming(1, { duration: 500 });
    
    logoScale.value = withDelay(
      300,
      withSequence(
        withTiming(1.2, { duration: 600 }),
        withTiming(1, { duration: 200 })
      )
    );
    
    logoOpacity.value = withDelay(300, withTiming(1, { duration: 600 }));
    
    textOpacity.value = withDelay(
      800,
      withTiming(1, { duration: 500 }, () => {
        runOnJS(setTimeout)(navigateToAuth, 1500);
      })
    );
  }, []);

  const logoAnimatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: logoScale.value }],
    opacity: logoOpacity.value,
  }));

  const textAnimatedStyle = useAnimatedStyle(() => ({
    opacity: textOpacity.value,
  }));

  const gradientAnimatedStyle = useAnimatedStyle(() => ({
    opacity: gradientOpacity.value,
  }));

  return (
    <View className="flex-1 bg-white">
      <Animated.View style={[{ flex: 1 }, gradientAnimatedStyle]}>
        <LinearGradient
          colors={['#ffffff', '#f0f9ff', '#e0f2fe']}
          className="flex-1 justify-center items-center"
        >
          {/* Logo Container */}
          <Animated.View 
            style={logoAnimatedStyle}
            className="items-center mb-8"
          >
            <View className="w-20 h-20 bg-primary-600 rounded-2xl items-center justify-center mb-4 shadow-lg">
              <Ionicons name="newspaper-outline" size={40} color="white" />
            </View>
          </Animated.View>

          {/* App Name */}
          <Animated.View style={textAnimatedStyle} className="items-center">
            <Text className="text-3xl font-inter-bold text-gray-900 mb-2">
              TechNews
            </Text>
            <Text className="text-base font-inter text-gray-600 text-center">
              Stay ahead with the latest tech insights
            </Text>
          </Animated.View>

          {/* Loading Indicator */}
          <View className="absolute bottom-20">
            <View className="w-8 h-8">
              <View className="w-full h-full border-2 border-primary-200 border-t-primary-600 rounded-full animate-spin" />
            </View>
          </View>
        </LinearGradient>
      </Animated.View>
    </View>
  );
}