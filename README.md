# TechNews - Modern Tech News Mobile App

A beautiful and modern React Native mobile app for tech news enthusiasts, built with Expo, TailwindCSS, and modern UI principles.

## ✨ Features

- **🎨 Modern UI Design** - Clean, minimal interface with smooth animations
- **🔐 Authentication** - Apple Sign-In, Google Sign-In, and Magic Link email auth
- **💳 Subscription System** - $9.99/month or $59.99/year with 7-day free trial
- **📱 Beautiful Components** - Carefully crafted with TailwindCSS and Shadcn UI principles
- **🎭 Smooth Animations** - React Native Reanimated for fluid interactions
- **📰 News Feed** - Personalized tech news with categories and filters
- **🔔 Push Notifications** - Breaking news and personalized alerts (ready for implementation)
- **📖 Offline Reading** - Save articles for offline access
- **🎯 Premium Features** - AI summaries, expert analysis, and ad-free experience

## 🛠 Tech Stack

- **Framework**: React Native with Expo
- **Styling**: TailwindCSS (NativeWind)
- **Navigation**: Expo Router
- **Animations**: React Native Reanimated
- **Authentication**: Supabase Auth
- **Backend**: Supabase
- **Subscriptions**: React Native Purchases (RevenueCat ready)
- **Icons**: Expo Vector Icons (Ionicons)
- **Fonts**: Inter font family

## 🎨 Design System

### Color Palette
- **Primary Blue**: Subtle blue shades (#0ea5e9 to #0c4a6e)
- **Grays**: Clean gray scale (#f8fafc to #0f172a)
- **White**: Pure white backgrounds
- **Black**: Deep black for text and accents

### Typography
- **Inter Font Family**: Regular, Medium, SemiBold, Bold
- Carefully sized text hierarchy
- Excellent readability on mobile devices

## 🚀 Getting Started

### Prerequisites
- Node.js (v18 or later)
- npm or yarn
- Expo CLI
- iOS Simulator or Android Emulator
- Supabase account (for backend)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd technews
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   Create an `app.config.js` file with your Supabase credentials:
   ```javascript
   export default {
     expo: {
       // ... other config
       extra: {
         supabaseUrl: 'YOUR_SUPABASE_URL',
         supabaseAnonKey: 'YOUR_SUPABASE_ANON_KEY',
       },
     },
   };
   ```

4. **Add required fonts**
   Download Inter font files and place them in `assets/fonts/`:
   - Inter-Regular.ttf
   - Inter-Medium.ttf
   - Inter-SemiBold.ttf
   - Inter-Bold.ttf

5. **Add app icons and splash images**
   Place your app assets in the `assets/` folder:
   - icon.png (1024x1024)
   - splash.png
   - adaptive-icon.png
   - favicon.png

6. **Start the development server**
   ```bash
   npx expo start
   ```

## 📁 Project Structure

```
technews/
├── app/                      # App screens and layouts
│   ├── (auth)/              # Authentication screens
│   │   ├── welcome.tsx      # Welcome/onboarding
│   │   ├── login.tsx        # Login with magic link
│   │   └── signup.tsx       # Sign up screen
│   ├── (main)/              # Main app screens
│   │   ├── home.tsx         # News feed
│   │   ├── discover.tsx     # Discover screen
│   │   ├── bookmarks.tsx    # Saved articles
│   │   └── profile.tsx      # User profile
│   ├── splash.tsx           # Splash screen
│   ├── subscription.tsx     # Subscription plans
│   ├── _layout.tsx          # Root layout
│   └── index.tsx            # Entry point
├── lib/                     # Utilities and services
│   └── supabase.ts          # Supabase client
├── assets/                  # Images, fonts, icons
├── components/              # Reusable components (to be added)
├── app.json                 # Expo configuration
├── package.json             # Dependencies
├── tailwind.config.js       # TailwindCSS config
├── babel.config.js          # Babel configuration
└── global.css               # Global styles
```

## 🔧 Configuration

### Supabase Setup
1. Create a new Supabase project
2. Enable Authentication and configure providers:
   - Email (Magic Links)
   - Google OAuth
   - Apple OAuth
3. Set up your database tables for users and articles
4. Configure RLS (Row Level Security) policies

### Push Notifications
The app is prepared for push notifications using Expo Notifications. Configure your notification settings in the Expo console.

### Subscriptions
The app uses React Native Purchases for subscription management. You'll need to:
1. Set up products in App Store Connect and Google Play Console
2. Configure RevenueCat (recommended) or implement direct subscription handling
3. Update the subscription logic in `app/subscription.tsx`

## 📱 App Flow

1. **Splash Screen** - Animated logo and loading
2. **Welcome Screen** - Authentication options
3. **Login/Signup** - Magic link email authentication
4. **Subscription** - Premium upgrade with free trial
5. **Main App** - Tab navigation with news feed

## 🎨 Design Features

- **Smooth Animations** - Every screen has carefully crafted entrance animations
- **Modern UI** - Clean, minimal design following iOS and Android guidelines
- **Responsive Layout** - Optimized for all screen sizes
- **Accessibility** - Built with accessibility in mind
- **Dark Mode Ready** - Color system supports dark mode implementation

## 🔐 Authentication Flow

1. User selects authentication method (Apple/Google/Email)
2. For email: Magic link sent to user's email
3. User clicks link to authenticate
4. Redirected to subscription screen (new users) or main app
5. Supabase manages session and user state

## 💰 Subscription Model

- **Monthly**: $9.99/month
- **Annual**: $59.99/year (50% savings)
- **Free Trial**: 7 days, cancel anytime
- **Premium Features**: 
  - Unlimited articles
  - AI summaries
  - Offline reading
  - No ads
  - Breaking news notifications

## 🚀 Deployment

### iOS
1. Build with EAS Build: `eas build --platform ios`
2. Submit to App Store: `eas submit --platform ios`

### Android
1. Build with EAS Build: `eas build --platform android`
2. Submit to Google Play: `eas submit --platform android`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🎯 Next Steps

- [ ] Implement actual news API integration
- [ ] Add article reading screen with rich text
- [ ] Implement search functionality
- [ ] Add user preferences and categories
- [ ] Implement push notifications
- [ ] Add offline storage with SQLite
- [ ] Implement social sharing
- [ ] Add dark mode support
- [ ] Add analytics and crash reporting

## 📞 Support

For support, email support@technews.app or create an issue in this repository.

---

Built with ❤️ using React Native and Expo