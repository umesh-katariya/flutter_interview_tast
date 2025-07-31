# 📱 Flutter Interview Task App

A modular Flutter application following the **MVVM architecture** using **Riverpod** for state management, **Drift (SQLite)** for local storage, and **Firebase Authentication**. The app supports **English and Arabic localization**, **light/dark theme switching**, and demonstrates best practices for scalable and maintainable codebases.

---

## 🔧 Tech Stack

- ✅ Flutter
- ✅ Riverpod (state management)
- ✅ MVVM Architecture
- ✅ Firebase Authentication
- ✅ Drift (local storage)
- ✅ Localization (English 🇺🇸, Arabic 🇸🇦)
- ✅ Light/Dark Theme Toggle
- ✅ Modular Folder Structure

---

## 📐 Architecture

The app uses **MVVM** (Model-View-ViewModel):

- **Model** – Represents the app data, handles network/database.
- **ViewModel** – Holds UI logic, interacts with repositories and exposes states.
- **View** – Pure UI widgets that listen to ViewModel state.

Riverpod's provider system cleanly separates concerns and simplifies dependency injection.

---

## 📁 Folder Structure

lib/
├── core/
│   ├── localization/         # ARB files, AppLocalizations, locale logic
│   ├── providers/            # Global providers (theme, locale)
│   ├── theme/                # App themes
│   └── widgets/              # Reusable UI components
├── data/
│   ├── api/                  # Common API Setup
│   ├── repository/           # Repositories to manage data
│   ├── local/                # Drift setup
│   └── models/               # Data models
├── features/
│   ├── auth/
│   │   ├── views/            # LoginScreen
│   │   └── viewmodels/       # AuthViewModel
│   ├── dashboard/
│   │   └── views/            # Dashboard UI with theme/lang toggle
│   └── users/
│       ├── views/            # UserListScreen, UserDetailScreen
│       └── viewmodels/       # UserViewModel
├── main.dart                 # App root with localization, theming
└── router                    # go_router navigation setup


## 🌍 Localization

- Implemented using Flutter's native localization.
- Supported languages: **English (en)** and **Arabic (ar)**.
- Language toggle via app bar `PopupMenuButton`.

---

## 🎨 Theme Support

- Switch between **Light** and **Dark** themes.
- Managed using a `StateProvider<ThemeMode>` and applied globally.
- Toggle icon on dashboard app bar.

---

## 🔐 Authentication

- Firebase email/password login
- Validates credentials and handles error messages
- Logout button provided in app bar

---

## 🧑‍💼 User Management

- User list fetched via repository (extendable to REST API)
- View user details on separate screen
- Loading, error, and empty state handling included

---

## 🚀 Performance Decisions

- **Riverpod** for optimized rebuilds and decoupled logic
- **Drift** for reactive local storage (lightweight and type-safe)
- UI updates driven by state only (no direct mutation)
- Avoids `setState()` misuse by relying on ViewModel logic
- Theme and locale changes are globally reactive

---

# ⚙️ Code Generation

### 🈯 Localization

```bash
flutter gen-l10n
```

### 💾 Drift

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Use this after modifying Drift files to regenerate database classes.

---

## 🧪 To Run the App

```bash
flutter pub get
flutter run
```

---

## 🧪 Test Credentials

```
Email: test@gmail.com
Password: 123456
```