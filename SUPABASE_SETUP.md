# Supabase Setup Guide

This guide will help you set up Supabase for your React Native app to enable magic link authentication.

## 1. Create a Supabase Project

1. Go to [https://supabase.com](https://supabase.com)
2. Sign up/Sign in to your account
3. Click "New Project"
4. Choose your organization
5. Enter project details:
   - **Name**: Your app name (e.g., "TechNews")
   - **Database Password**: Create a strong password
   - **Region**: Choose the closest region to your users
6. Click "Create new project"

## 2. Get Your Project Credentials

Once your project is created:

1. Go to **Settings** → **API** in your Supabase dashboard
2. You'll find these important values:
   - **Project URL** (starts with `https://your-project-id.supabase.co`)
   - **Project API Key** → **anon** → **public** (this is your anon key)

## 3. Configure Environment Variables

Create a `.env.local` file in your project root (if you don't have one) and add:

```env
EXPO_PUBLIC_SUPABASE_URL=your_project_url_here
EXPO_PUBLIC_SUPABASE_ANON_KEY=your_anon_key_here
```

**Important**: Replace the placeholder values with your actual Supabase credentials.

## 4. Configure Authentication Settings

### Enable Email Authentication
1. In your Supabase dashboard, go to **Authentication** → **Settings**
2. Under **Auth Providers**, make sure **Email** is enabled
3. Configure **Email Templates** if you want to customize the magic link email

### Configure Site URL (Important for Magic Links)
1. In **Authentication** → **Settings** → **Site URL**
2. Set your site URL to match your app's deep link scheme:
   - For development: `exp://192.168.1.xxx:8081` (your Expo dev server URL)
   - For production: `yourapp://` (your custom URL scheme)

### Configure Redirect URLs
1. In **Authentication** → **Settings** → **Redirect URLs**
2. Add your redirect URLs:
   - `exp://192.168.1.xxx:8081` (for development)
   - `yourapp://login` (for production)
   - Any other URLs your app might redirect to

## 5. Set Up Email Templates (Optional)

1. Go to **Authentication** → **Email Templates**
2. Customize the "Magic Link" template if desired
3. You can use these variables in your template:
   - `{{ .Token }}` - The magic link token
   - `{{ .Email }}` - User's email
   - `{{ .RedirectTo }}` - Redirect URL
   - `{{ .SiteURL }}` - Your site URL

## 6. Configure Deep Linking (For Production)

### Update app.json
Add the following to your `app.json`:

```json
{
  "expo": {
    "scheme": "yourapp",
    "// ... other config": ""
  }
}
```

### Update the signup.tsx redirect URL
In your `signup.tsx`, update the `emailRedirectTo` value:

```typescript
const { data, error } = await supabase.auth.signInWithOtp({
  email: email.trim().toLowerCase(),
  options: {
    emailRedirectTo: 'yourapp://login', // Replace 'yourapp' with your actual scheme
  },
});
```

## 7. Test the Setup

1. Make sure your environment variables are properly set
2. Restart your Expo development server
3. Try signing up with a real email address
4. Check your email for the magic link
5. Clicking the link should redirect to your app

## 8. Wrap Your App with AuthProvider

Update your root layout to include the AuthProvider:

```typescript
// app/_layout.tsx
import { AuthProvider } from '../lib/auth-context';

export default function RootLayout() {
  return (
    <AuthProvider>
      {/* Your existing layout components */}
    </AuthProvider>
  );
}
```

## Troubleshooting

### Magic Link Not Sending
1. Check that your Supabase credentials are correct in `.env.local`
2. Verify that Email authentication is enabled in Supabase
3. Check the Console/Network tab for any error messages
4. Make sure your email isn't in spam

### Magic Link Not Working
1. Verify your Site URL and Redirect URLs are correctly configured
2. Check that your deep linking scheme matches your app.json
3. For development, use the Expo dev server URL as redirect

### Environment Variables Not Loading
1. Make sure the file is named `.env.local` (not `.env`)
2. Restart your Expo development server after adding variables
3. Variables must start with `EXPO_PUBLIC_` to be accessible in React Native

## Security Notes

- Never commit your `.env.local` file to version control
- The anon key is safe to use in client-side code
- Never use the service_role key in client-side code
- Always validate user input on the server side