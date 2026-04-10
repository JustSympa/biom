# BioM - Plant Health Diagnosis App

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-blue.svg)](https://dart.dev)

BioM is a mobile application that helps gardeners, farmers, and plant enthusiasts diagnose plant health issues instantly using AI technology. Simply take a photo of your plant and get comprehensive analysis including disease identification, nutrient deficiencies, and personalized care recommendations.

## 📱 Features

- **Instant Plant Diagnosis**: Take a photo or upload from gallery to get immediate health analysis
- **Multi-category Detection**:
  - Plant diseases with treatment recommendations
  - Nutrient deficiencies with correction advice
  - Pest infestations with control methods
  - Watering issues with optimal schedule suggestions
- **Detailed Analysis Reports**: Get comprehensive information about identified issues
- **Treatment Recommendations**: Receive actionable advice for plant care
- **History Tracking**: Save and review past diagnoses
- **Offline Capability**: Access basic plant care guides without internet

## 🎨 Design System

### Color Palette

- **Background**: White (#FFFFFF)
- **Foreground/Text**: Black (#000000)
- **Brand/Accent**: Green (#3c8137)

### Typography

- Clean, readable fonts for optimal user experience
- Hierarchical text sizing for clear information structure

## 🛠️ Technology Stack

- **Framework**: Flutter (Cross-platform)
- **Language**: Dart
- **AI Integration**: TensorFlow Lite / Custom AI API
- **Camera Integration**: Camera plugin for Flutter
- **State Management**: Provider / Riverpod
- **Local Storage**: SQLite / Hive

## 📋 Prerequisites

- Flutter SDK (version 3.x or higher)
- Dart SDK (version 3.x or higher)
- Android Studio / VS Code with Flutter extensions
- Android SDK (for Android development)
- iOS development tools (for iOS builds)

## 🚀 Installation

1. Clone the repository:

```bash
git clone https://github.com/JustSympa/biom.git
```

2. Navigate to project directory:

```bash
cd biom-plant-diagnosis
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart
├── models/
│   ├── diagnosis_model.dart
│   └── plant_model.dart
├── views/
│   ├── home_screen.dart
│   ├── camera_screen.dart
│   ├── diagnosis_screen.dart
│   └── history_screen.dart
├── widgets/
│   ├── custom_button.dart
│   ├── diagnosis_card.dart
│   └── loading_indicator.dart
├── services/
│   ├── ai_service.dart
│   ├── camera_service.dart
│   └── storage_service.dart
├── utils/
│   ├── constants.dart
│   └── validators.dart
└── theme/
    └── app_theme.dart
```

## 🔧 Configuration

### Android Setup

Add camera permission to `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```


## 🎯 Core Features Implementation

### 1. Camera Integration

- Real-time camera preview
- Image capture functionality
- Gallery image selection
- Image cropping and optimization

### 2. AI Diagnosis Engine

- Image preprocessing for AI model
- Integration with plant disease detection API
- Confidence scoring for diagnoses
- Multi-label classification support

### 3. Result Presentation

- Clean, readable diagnosis results
- Visual indicators for plant health status
- Step-by-step treatment guides
- Severity indicators and urgency levels

## 📊 Sample Diagnosis Categories

### Diseases

- Powdery Mildew
- Leaf Spot
- Rust
- Root Rot
- Bacterial Wilt

### Nutrient Deficiencies

- Nitrogen deficiency
- Phosphorus deficiency
- Potassium deficiency
- Iron deficiency
- Magnesium deficiency

### Pests

- Aphids
- Spider mites
- Whiteflies
- Mealybugs
- Scale insects

### Watering Issues

- Overwatering symptoms
- Underwatering symptoms
- Optimal watering schedule
- Humidity recommendations

## 🧪 Testing

Run tests:

```bash
flutter test
```

Run specific test file:

```bash
flutter test test/diagnosis_service_test.dart
```

## 📱 Screenshots

(Add your app screenshots here)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is created for educational purposes as part of Android Application Development course.

## 👥 Team

- BINDZI KEVIN ELYSE - Development
- NINDJIO TANDAH BIENVENU ABRAHAM - Testing

## 🙏 Acknowledgments

- Lecturer for project guidance and requirements
- Plant disease datasets and research papers
- Flutter community for excellent documentation
- Open-source contributors for various packages used

---

**Note**: This is a student project developed for academic purposes. The accuracy of plant diagnoses should be verified with professional agricultural experts for critical applications.
