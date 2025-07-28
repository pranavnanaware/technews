# Assets Directory

This directory contains all the static assets for the TechNews app.

## Required Files

Please add the following files to their respective directories:

### App Icons
- `icon.png` - Main app icon (1024x1024 px)
- `adaptive-icon.png` - Android adaptive icon foreground (1024x1024 px)
- `favicon.png` - Web favicon (48x48 px)

### Splash Screen
- `splash.png` - Splash screen image (1284x2778 px for iPhone 12/13/14)

### Notifications
- `notification-icon.png` - Push notification icon (256x256 px)

### Fonts
Create a `fonts/` directory and add:
- `Inter-Regular.ttf`
- `Inter-Medium.ttf`
- `Inter-SemiBold.ttf`
- `Inter-Bold.ttf`

You can download the Inter font family from:
https://fonts.google.com/specimen/Inter

### Images (Optional)
Create an `images/` directory for any additional images:
- Logo variations
- Placeholder images
- Illustrations
- Background images

## Directory Structure

```
assets/
├── README.md
├── icon.png
├── adaptive-icon.png
├── favicon.png
├── splash.png
├── notification-icon.png
├── fonts/
│   ├── Inter-Regular.ttf
│   ├── Inter-Medium.ttf
│   ├── Inter-SemiBold.ttf
│   └── Inter-Bold.ttf
└── images/
    └── (your additional images)
```

## Image Guidelines

### App Icon
- Size: 1024x1024 px
- Format: PNG with transparency
- Style: Modern, minimal, recognizable
- Colors: Match app color scheme (blues, whites, grays)

### Splash Screen
- Size: 1284x2778 px (iPhone 14 Pro resolution)
- Format: PNG
- Background: White (#ffffff)
- Content: Simple logo or branding, minimal text
- Style: Clean and fast-loading

### Adaptive Icon (Android)
- Size: 1024x1024 px
- Format: PNG with transparency
- Design: Icon should work on various background shapes
- Safe area: Keep important elements in center 66% of the image

## Color Guidelines

All images should follow the app's color scheme:
- Primary: #0ea5e9 (blue-500)
- Secondary: #0284c7 (blue-600)
- Accent: #075985 (blue-800)
- Background: #ffffff (white)
- Text: #0f172a (gray-900)

## Optimization

- Use PNG for images with transparency
- Use JPEG for photos without transparency
- Optimize file sizes for mobile performance
- Test images on various screen densities