# Chat App with Firebase Integration

A Swift-based chat application with Firebase integration for user authentication, real-time messaging, and storage.

## Contributors

- [Ermal Limaj](https://github.com/ermallimaj)
- [Gentrit Bytyçi](https://github.com/Genti1bytyqi)

## Table of Contents

- Introduction
- Features
- Installation
- Usage
- Firebase Setup
- Contributing
- License

## Introduction

The "chat-app-firebase-swift" project is a chat application built using SwiftUI and Firebase. It allows users to register, log in, and send messages to other users in real-time.

## Features

- **User authentication:** Register and log in securely with Firebase Authentication.
- **Real-time messaging:** Send and receive messages instantly using Firebase Firestore.
- **Profile image support:** Upload and display profile images for users using Firebase Storage.
- **Intuitive user interface:** Designed with SwiftUI for a smooth and modern user experience.

## Installation

To run the project locally, follow these steps:

1. **Clone the repository:**

   git clone https://github.com/ermallimaj/chat-app-using-firebase

2. **Open the project in Xcode.**

3. **Install dependencies using CocoaPods:**

   cd chat-app-firebase-swift
   pod install

4. **Configure Firebase:**

   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/).
   - Add your iOS app to the Firebase project and follow the setup instructions to download the `GoogleService-Info.plist` file.
   - Place the downloaded `GoogleService-Info.plist` file in the project directory.

5. **Build and run the project in Xcode.**

## Usage

Once the project is running, you can:

- Register a new account or log in with an existing account.
- View a list of users and start a chat conversation with any user.
- Send messages in real-time and view incoming messages instantly.

## Firebase Setup

This project requires Firebase services for user authentication, real-time database, and storage. Follow these steps to set up Firebase for the project:

1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/).
2. Add an iOS app to the Firebase project and follow the setup instructions to download the `GoogleService-Info.plist` file.
3. Enable Firebase Authentication, Firestore, and Storage in the Firebase project settings.
4. Configure Firebase in the Xcode project by adding the `GoogleService-Info.plist` file to the project directory.

For detailed instructions on Firebase setup, refer to the [Firebase documentation](https://firebase.google.com/docs/ios/setup).

## Contributing

Contributions are welcome! If you'd like to contribute to the project, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/add-new-feature`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add new feature'`).
5. Push to the branch (`git push origin feature/add-new-feature`).
6. Create a new Pull Request.

