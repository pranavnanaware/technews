import React, { useState, useEffect } from 'react';
import { View, Text, TouchableOpacity, ScrollView, Alert } from 'react-native';
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

type PricingPlan = 'monthly' | 'annual';

export default function SubscriptionScreen() {
  const [selectedPlan, setSelectedPlan] = useState<PricingPlan>('annual');
  const [isLoading, setIsLoading] = useState(false);

  const headerOpacity = useSharedValue(0);
  const contentTranslateY = useSharedValue(30);
  const contentOpacity = useSharedValue(0);

  useEffect(() => {
    headerOpacity.value = withTiming(1, { duration: 600 });
    contentTranslateY.value = withDelay(200, withSpring(0, { damping: 15, stiffness: 100 }));
    contentOpacity.value = withDelay(200, withTiming(1, { duration: 500 }));
  }, []);

  const headerAnimatedStyle = useAnimatedStyle(() => ({
    opacity: headerOpacity.value,
  }));

  const contentAnimatedStyle = useAnimatedStyle(() => ({
    transform: [{ translateY: contentTranslateY.value }],
    opacity: contentOpacity.value,
  }));

  const handleStartTrial = async () => {
    setIsLoading(true);
    
    try {
      // TODO: Implement subscription logic with RevenueCat or similar
      // await purchasePackage(selectedPlan);
      
      // Simulate purchase
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      Alert.alert(
        'Welcome to TechNews Premium!',
        'Your 7-day free trial has started. Enjoy unlimited access to all premium features.',
        [
          {
            text: 'Get Started',
            onPress: () => router.replace('/(main)/home'),
          },
        ]
      );
    } catch (error) {
      Alert.alert('Error', 'Failed to start trial. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };

  const features = [
    'Unlimited article access',
    'AI-powered news summaries',
    'Personalized recommendations',
    'Offline reading mode',
    'No advertisements',
    'Breaking news notifications',
    'Weekly tech insights',
    'Expert analysis & opinions',
  ];

  return (
    <SafeAreaView className="flex-1 bg-white">
      <LinearGradient
        colors={['#ffffff', '#f8fafc', '#f0f9ff']}
        className="flex-1"
      >
        {/* Header */}
        <View className="px-6 py-4 flex-row items-center justify-between">
          <TouchableOpacity
            className="w-10 h-10 rounded-full bg-gray-100 items-center justify-center"
            onPress={() => router.back()}
          >
            <Ionicons name="arrow-back" size={24} color="#374151" />
          </TouchableOpacity>
          
          <TouchableOpacity onPress={() => router.replace('/(main)/home')}>
            <Text className="text-primary-600 text-base font-inter-medium">
              Skip
            </Text>
          </TouchableOpacity>
        </View>

        <ScrollView className="flex-1" showsVerticalScrollIndicator={false}>
          <View className="px-6">
            {/* Hero Section */}
            <Animated.View style={headerAnimatedStyle} className="items-center mb-8">
              <View className="w-20 h-20 bg-primary-600 rounded-3xl items-center justify-center mb-6">
                <Ionicons name="diamond-outline" size={40} color="white" />
              </View>
              
              <Text className="text-3xl font-inter-bold text-gray-900 text-center mb-3">
                Upgrade to Premium
              </Text>
              
              <Text className="text-base font-inter text-gray-600 text-center px-4">
                Get unlimited access to premium tech news and insights
              </Text>
            </Animated.View>

            <Animated.View style={contentAnimatedStyle}>
              {/* Pricing Plans */}
              <View className="mb-8">
                {/* Annual Plan */}
                <TouchableOpacity
                  className={`border-2 rounded-2xl p-4 mb-4 ${
                    selectedPlan === 'annual' 
                      ? 'border-primary-600 bg-primary-50' 
                      : 'border-gray-200 bg-white'
                  }`}
                  onPress={() => setSelectedPlan('annual')}
                >
                  <View className="flex-row items-center justify-between mb-2">
                    <View className="flex-row items-center">
                      <View className={`w-5 h-5 rounded-full border-2 mr-3 items-center justify-center ${
                        selectedPlan === 'annual' ? 'border-primary-600' : 'border-gray-300'
                      }`}>
                        {selectedPlan === 'annual' && (
                          <View className="w-3 h-3 rounded-full bg-primary-600" />
                        )}
                      </View>
                      <Text className="text-lg font-inter-semibold text-gray-900">
                        Annual Plan
                      </Text>
                    </View>
                    <View className="bg-green-100 px-3 py-1 rounded-full">
                      <Text className="text-green-700 text-sm font-inter-medium">
                        Save 50%
                      </Text>
                    </View>
                  </View>
                  
                  <View className="ml-8">
                    <Text className="text-2xl font-inter-bold text-gray-900">
                      $59.99
                      <Text className="text-base font-inter text-gray-500"> /year</Text>
                    </Text>
                    <Text className="text-sm font-inter text-gray-500">
                      Just $5.00 per month
                    </Text>
                  </View>
                </TouchableOpacity>

                {/* Monthly Plan */}
                <TouchableOpacity
                  className={`border-2 rounded-2xl p-4 ${
                    selectedPlan === 'monthly' 
                      ? 'border-primary-600 bg-primary-50' 
                      : 'border-gray-200 bg-white'
                  }`}
                  onPress={() => setSelectedPlan('monthly')}
                >
                  <View className="flex-row items-center mb-2">
                    <View className={`w-5 h-5 rounded-full border-2 mr-3 items-center justify-center ${
                      selectedPlan === 'monthly' ? 'border-primary-600' : 'border-gray-300'
                    }`}>
                      {selectedPlan === 'monthly' && (
                        <View className="w-3 h-3 rounded-full bg-primary-600" />
                      )}
                    </View>
                    <Text className="text-lg font-inter-semibold text-gray-900">
                      Monthly Plan
                    </Text>
                  </View>
                  
                  <View className="ml-8">
                    <Text className="text-2xl font-inter-bold text-gray-900">
                      $9.99
                      <Text className="text-base font-inter text-gray-500"> /month</Text>
                    </Text>
                  </View>
                </TouchableOpacity>
              </View>

              {/* Features List */}
              <View className="mb-8">
                <Text className="text-lg font-inter-semibold text-gray-900 mb-4">
                  What's included:
                </Text>
                
                <View className="space-y-3">
                  {features.map((feature, index) => (
                    <View key={index} className="flex-row items-center">
                      <View className="w-6 h-6 bg-green-100 rounded-full items-center justify-center mr-3">
                        <Ionicons name="checkmark" size={16} color="#059669" />
                      </View>
                      <Text className="text-base font-inter text-gray-700 flex-1">
                        {feature}
                      </Text>
                    </View>
                  ))}
                </View>
              </View>

              {/* Trial Notice */}
              <View className="bg-blue-50 border border-blue-200 rounded-2xl p-4 mb-8">
                <View className="flex-row items-center mb-2">
                  <Ionicons name="gift-outline" size={20} color="#2563EB" />
                  <Text className="text-blue-800 text-base font-inter-semibold ml-2">
                    7-Day Free Trial
                  </Text>
                </View>
                <Text className="text-blue-700 text-sm font-inter">
                  Start your free trial today. Cancel anytime during the trial period with no charges.
                </Text>
              </View>

              {/* CTA Button */}
              <TouchableOpacity
                className={`rounded-2xl py-4 px-6 mb-6 ${
                  isLoading ? 'bg-primary-400' : 'bg-primary-600'
                }`}
                onPress={handleStartTrial}
                disabled={isLoading}
              >
                {isLoading ? (
                  <View className="flex-row items-center justify-center">
                    <View className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin mr-3" />
                    <Text className="text-white text-lg font-inter-semibold">
                      Starting Trial...
                    </Text>
                  </View>
                ) : (
                  <Text className="text-white text-lg font-inter-semibold text-center">
                    Start 7-Day Free Trial
                  </Text>
                )}
              </TouchableOpacity>

              {/* Footer Text */}
              <View className="items-center pb-8">
                <Text className="text-xs font-inter text-gray-500 text-center leading-relaxed">
                  By starting your trial, you agree to our{' '}
                  <Text className="text-primary-600">Terms of Service</Text> and{' '}
                  <Text className="text-primary-600">Privacy Policy</Text>.{'\n'}
                  Your subscription will auto-renew unless cancelled 24 hours before the trial ends.
                </Text>
              </View>
            </Animated.View>
          </View>
        </ScrollView>
      </LinearGradient>
    </SafeAreaView>
  );
}