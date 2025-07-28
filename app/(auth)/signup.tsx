import React, { useState, useEffect } from 'react';
import { View, Text, TextInput, TouchableOpacity, Alert, KeyboardAvoidingView, Platform } from 'react-native';
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

export default function SignUpScreen() {
  const [email, setEmail] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [isEmailSent, setIsEmailSent] = useState(false);

  const headerOpacity = useSharedValue(0);
  const formTranslateY = useSharedValue(30);
  const formOpacity = useSharedValue(0);

  useEffect(() => {
    headerOpacity.value = withTiming(1, { duration: 600 });
    formTranslateY.value = withDelay(200, withSpring(0, { damping: 15, stiffness: 100 }));
    formOpacity.value = withDelay(200, withTiming(1, { duration: 500 }));
  }, []);

  const headerAnimatedStyle = useAnimatedStyle(() => ({
    opacity: headerOpacity.value,
  }));

  const formAnimatedStyle = useAnimatedStyle(() => ({
    transform: [{ translateY: formTranslateY.value }],
    opacity: formOpacity.value,
  }));

  const validateEmail = (email: string) => {
    return email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/);
  };

  const handleCreateAccount = async () => {
    if (!email.trim()) {
      Alert.alert('Error', 'Please enter your email address');
      return;
    }

    if (!validateEmail(email)) {
      Alert.alert('Error', 'Please enter a valid email address');
      return;
    }

    setIsLoading(true);

    try {
      // TODO: Implement Supabase signup with magic link
      // await supabase.auth.signUp({ email })
      
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      setIsEmailSent(true);
      Alert.alert(
        'Check your email',
        'We\'ve sent you a magic link to create your account. Please check your email and click the link to continue.',
        [{ text: 'OK' }]
      );
    } catch (error) {
      Alert.alert('Error', 'Failed to create account. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };

  const handleResendEmail = () => {
    setIsEmailSent(false);
    handleCreateAccount();
  };

  if (isEmailSent) {
    return (
      <SafeAreaView className="flex-1 bg-white">
        <LinearGradient
          colors={['#ffffff', '#f8fafc', '#f0f9ff']}
          className="flex-1"
        >
          <View className="flex-1 px-6 justify-center items-center">
            <View className="w-20 h-20 bg-green-100 rounded-full items-center justify-center mb-6">
              <Ionicons name="mail-outline" size={40} color="#059669" />
            </View>
            
            <Text className="text-2xl font-inter-bold text-gray-900 text-center mb-4">
              Check your email
            </Text>
            
            <Text className="text-base font-inter text-gray-600 text-center mb-8 px-4">
              We've sent a magic link to{'\n'}
              <Text className="font-inter-semibold text-gray-900">{email}</Text>
            </Text>
            
            <TouchableOpacity
              className="bg-primary-600 rounded-2xl py-4 px-8 mb-4"
              onPress={handleResendEmail}
            >
              <Text className="text-white text-lg font-inter-semibold">
                Resend Email
              </Text>
            </TouchableOpacity>
            
            <TouchableOpacity
              className="py-3"
              onPress={() => setIsEmailSent(false)}
            >
              <Text className="text-primary-600 text-base font-inter-medium">
                Use different email
              </Text>
            </TouchableOpacity>
          </View>
        </LinearGradient>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView className="flex-1 bg-white">
      <LinearGradient
        colors={['#ffffff', '#f8fafc', '#f0f9ff']}
        className="flex-1"
      >
        <KeyboardAvoidingView 
          behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
          className="flex-1"
        >
          {/* Header */}
          <View className="px-6 py-4">
            <TouchableOpacity
              className="w-10 h-10 rounded-full bg-gray-100 items-center justify-center"
              onPress={() => router.back()}
            >
              <Ionicons name="arrow-back" size={24} color="#374151" />
            </TouchableOpacity>
          </View>

          <View className="flex-1 px-6">
            {/* Title Section */}
            <Animated.View style={headerAnimatedStyle} className="items-center mb-12">
              <Text className="text-3xl font-inter-bold text-gray-900 text-center mb-3">
                Create your account
              </Text>
              <Text className="text-base font-inter text-gray-600 text-center">
                Join thousands of tech enthusiasts staying informed
              </Text>
            </Animated.View>

            {/* Form Section */}
            <Animated.View style={formAnimatedStyle} className="flex-1">
              <View className="mb-6">
                <Text className="text-base font-inter-medium text-gray-700 mb-2">
                  Email address
                </Text>
                <TextInput
                  className="bg-white border border-gray-300 rounded-2xl px-4 py-4 text-base font-inter text-gray-900"
                  placeholder="Enter your email"
                  placeholderTextColor="#9CA3AF"
                  value={email}
                  onChangeText={setEmail}
                  keyboardType="email-address"
                  autoCapitalize="none"
                  autoCorrect={false}
                  autoComplete="email"
                />
              </View>

              <TouchableOpacity
                className={`rounded-2xl py-4 px-6 ${
                  isLoading ? 'bg-primary-400' : 'bg-primary-600'
                }`}
                onPress={handleCreateAccount}
                disabled={isLoading}
              >
                {isLoading ? (
                  <View className="flex-row items-center justify-center">
                    <View className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin mr-3" />
                    <Text className="text-white text-lg font-inter-semibold">
                      Creating Account...
                    </Text>
                  </View>
                ) : (
                  <Text className="text-white text-lg font-inter-semibold text-center">
                    Create Account
                  </Text>
                )}
              </TouchableOpacity>

              <View className="mt-8 items-center">
                <Text className="text-sm font-inter text-gray-500 text-center">
                  Already have an account?{' '}
                  <TouchableOpacity onPress={() => router.push('/(auth)/login')}>
                    <Text className="text-primary-600 font-inter-medium">
                      Sign in
                    </Text>
                  </TouchableOpacity>
                </Text>
              </View>
            </Animated.View>
          </View>
        </KeyboardAvoidingView>
      </LinearGradient>
    </SafeAreaView>
  );
}