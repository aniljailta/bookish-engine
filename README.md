# todo_list
A new Flutter project.
## Getting Started
This project is a starting point for a Flutter application.
A few resources to get you started if this is your first Flutter project:
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
## About the app
Flutter version used : 3.22.2
## Overview
This document provides the necessary information to set up, run, and understand the Todo List application built with Flutter. The application leverages GetX for state management and SQFlite for local database operations. This guide will help you navigate through the setup instructions, state management approach, and any assumptions made during development.
## Setup Instructions
Prerequisites
Flutter SDK: 3.22.2
## Cloning the Repository
Clone the repository from GitLab:
git clone <your-repository-url>
Navigate to the project directory:
Installing Dependencies
## Ensure you have all the dependencies installed by running:

## How to run the app on ios
cd ios
pod install --repo update
cd ..
flutter pub get
## Running the Application
Connect a physical device or start an emulator.
## Run the application using:
flutter run
## State Management Approach with GetX
GetX: GetX is used for state management in this application due to its simplicity and efficiency in managing state and dependencies.
GetX Controller: Handles the business logic and state of the Todo List.
Reactive State Management: GetX allows the state to be updated reactively, ensuring that UI components reflect the latest state without manual intervention.
Implementation Details:
Controllers are used to manage the state of todo items, including adding, updating, and deleting items.
Observables are used to listen for changes in the state, automatically updating the UI.
Dependency injection is managed by GetX to ensure that controllers are accessible where needed.
## Local Database Integration
Using SQFlite
SQFlite: SQFlite is used for local database operations to store and manage todo items.
Database Schema: The database schema includes a table for todo items with columns for id, title, and completed status.
CRUD Operations: Implemented methods for Create, Read, Update, and Delete operations to manage todo items.
Persistence: Data is persisted across app sessions, ensuring that todo items are retained even when the app is closed and reopened.
## Implementation Details:
A database helper class is used to handle database initialization and CRUD operations.
Data retrieval and updates are done using asynchronous operations to ensure smooth performance.
## Assumptions Made
Single User: The application assumes a single-user context. Multi-user support is not implemented.
Basic UI Requirements: The UI is designed to be simple and functional, focusing on core functionality rather than advanced design features.
Error Handling: Basic error handling is implemented. Additional validations and edge cases might be considered based on further requirements.