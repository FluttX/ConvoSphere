# ConvoSphere

A sleek and reliable chat application built with Flutter, Node.js, Socket.io, Bloc, and Clean Architecture.

---

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [License](#license)

---

## Introduction

ConvoSphere is a modern chat application designed to provide real-time communication with a seamless user experience. With its clean and modular architecture, the app ensures maintainability and scalability, making it a perfect foundation for robust messaging platforms.

---

## Features

- **Real-time Messaging**: Instant chat updates powered by Socket.io.
- **Cross-Platform**: Runs smoothly on Android, iOS, and the web with Flutter.
- **Scalable Backend**: Node.js ensures efficient handling of concurrent connections.
- **State Management**: Bloc ensures predictable and reusable application state.
- **Modular Architecture**: Built following Clean Architecture principles for maintainability.

---

## Tech Stack

### Frontend
- [Flutter](https://flutter.dev/): For building a beautiful and responsive UI.
- [Bloc](https://bloclibrary.dev/): For state management.

### Backend
- [Node.js](https://nodejs.org/): For a scalable and efficient backend.
- [Socket.io](https://socket.io/): For real-time bidirectional event-based communication.

---

## Architecture

ConvoSphere is built following Clean Architecture principles:

1. **Presentation Layer**: Handles UI and user interaction using Flutter widgets and Bloc.
2. **Domain Layer**: Contains business logic and use cases.
3. **Data Layer**: Manages data sources (API, database, etc.) and repositories.

This architecture promotes separation of concerns, testability, and scalability.

---

## Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Node.js](https://nodejs.org/)
- A code editor (e.g., [VS Code](https://code.visualstudio.com/))

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/FluttX/ConvoSphere.git
   ```

2. Navigate to the project directory:
   ```bash
   cd ConvoSphere
   ```

3. Install dependencies:
    - For Flutter:
      ```bash
      flutter pub get
      ```
    - For Node.js:
      ```bash
      cd backend
      npm install
      ```

4. Run the backend server:
   ```bash
   node server.js
   ```

5. Run the Flutter app:
   ```bash
   flutter run
   ```

---

## Contributing

We welcome contributions! To contribute:

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add a new feature"
   ```
4. Push to your branch:
   ```bash
   git push origin feature-name
   ```
5. Submit a pull request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
