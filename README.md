# CryptoCurrenciesApp

A comprehensive iOS application built to demonstrate modern networking patterns and API integration in Swift. This project showcases cryptocurrency data fetching from the CoinGecko API using clean architecture principles and modern SwiftUI practices.

<div align="center">
  <img src="https://img.shields.io/badge/SWIFT-5.9+-FA7343?style=for-the-badge&logo=swift&logoColor=white" alt="Swift">
  <img src="https://img.shields.io/badge/iOS-17.0+-000000?style=for-the-badge&logo=ios&logoColor=white" alt="iOS">
  <img src="https://img.shields.io/badge/SWIFTUI-FRAMEWORK-007AFF?style=for-the-badge&logo=swift&logoColor=white" alt="SwiftUI">
  <img src="https://img.shields.io/badge/COINGECKO-API-8CC152?style=for-the-badge&logo=bitcoin&logoColor=white" alt="CoinGecko API">
</div>

<div align="center">
  <img src="https://img.shields.io/badge/URLSESSION-NETWORKING-FF6B6B?style=for-the-badge&logo=network-wired&logoColor=white" alt="URLSession">
  <img src="https://img.shields.io/badge/ASYNC/AWAIT-CONCURRENCY-4ECDC4?style=for-the-badge&logo=swift&logoColor=white" alt="Async/Await">
  <img src="https://img.shields.io/badge/MVVM-ARCHITECTURE-9B59B6?style=for-the-badge&logo=architecture&logoColor=white" alt="MVVM">
  <img src="https://img.shields.io/badge/EDUCATIONAL-PROJECT-26C281?style=for-the-badge&logo=graduation-cap&logoColor=white" alt="Educational">
</div>

<br>

## Project Overview

This application serves as a practical learning resource for iOS developers looking to understand networking fundamentals, API integration, and modern Swift concurrency patterns. The app displays real-time cryptocurrency market data and detailed coin information through a clean, intuitive interface.

## Features

- **Real-time Cryptocurrency Data**: Fetches live market data for top 20 cryptocurrencies
- **Detailed Coin Information**: Navigate to detailed views with comprehensive coin descriptions
- **Smart Caching**: Implements intelligent caching for coin details to reduce API calls
- **Modern Networking**: Demonstrates both async/await and completion handler patterns
- **Clean Architecture**: MVVM pattern with clear separation of concerns
- **Error Handling**: Comprehensive error management with user-friendly messages

## Technical Implementation

### Architecture Pattern
The project follows the MVVM (Model-View-ViewModel) architectural pattern:
- **Models**: `Coin`, `CoinDetails`
- **Views**: SwiftUI-based interface with `ContentView` and `CoinDetailsView`
- **ViewModels**: `CoinsViewModel` and `CoinDetailsViewModel`

### Networking Layer
The networking implementation showcases multiple approaches:

1. **Protocol-Oriented Design**: `HTTPDataDownloader` protocol provides a flexible foundation
2. **Service Layer**: `CoinDataService` handles all API communications
3. **Modern Concurrency**: Utilizes Swift's async/await for clean asynchronous code
4. **Legacy Support**: Includes completion handler examples for educational purposes

### Caching Strategy
Implemented a simple but effective caching mechanism through `CoinDetailsCache` using NSCache to:
- Reduce unnecessary API calls
- Improve app performance
- Provide offline-like experience for previously viewed data

### Error Management
Comprehensive error handling through `CoinAPIError` enum covering:
- Network connectivity issues
- Invalid API responses
- JSON parsing errors
- HTTP status code validation

## Getting Started

### Prerequisites
- Xcode 15.0 or later
- iOS 17.0 or later
- Swift 5.9+

### Installation
1. Clone the repository
```bash
git clone https://github.com/dmakarau/CryptoCurrenciesApp.git
```
2. Open `CryptoCurrenciesApp.xcodeproj` in Xcode
3. Build and run the project on your preferred simulator or device

No external dependencies or API keys required - the app uses the free tier of the CoinGecko API.

## Learning Objectives

This project demonstrates:
- **Modern Swift Networking**: URLSession with async/await patterns
- **Protocol-Oriented Programming**: Clean, testable networking abstractions
- **SwiftUI Navigation**: NavigationStack and destination-based routing
- **Data Persistence**: NSCache implementation for temporary storage
- **Error Handling**: Robust error management strategies
- **Reactive Programming**: Observable objects and data binding

## API Integration

The application integrates with the [CoinGecko API](https://www.coingecko.com/en/api) endpoints:
- `/coins/markets` - Cryptocurrency market data
- `/coins/{id}` - Detailed coin information

All API interactions are handled through the service layer with proper error handling and response validation.

## Project Structure

```
CryptoCurrenciesApp/
├── Core/
│   ├── AllCoins/          # Main coin listing feature
│   │   ├── Model/
│   │   ├── Service/
│   │   ├── View/
│   │   └── ViewModel/
│   └── CoinDetails/       # Detailed coin view feature
│       ├── Cache/
│       ├── Model/
│       ├── View/
│       └── ViewModel/
├── Shared/
│   └── API/               # Networking protocols and utilities
└── Assets.xcassets/       # App icons and color assets
```

## Key Components

### Models
- **Coin**: Represents cryptocurrency market data
- **CoinDetails**: Extended coin information with descriptions
- **CoinAPIError**: Comprehensive error handling enumeration

### Services
- **CoinDataService**: Primary service for API communication
- **HTTPDataDownloader**: Protocol defining networking requirements

### ViewModels
- **CoinsViewModel**: Manages state for the main coin listing
- **CoinDetailsViewModel**: Handles detailed coin view logic

### Views
- **ContentView**: Main interface displaying cryptocurrency list
- **CoinDetailsView**: Detailed view with comprehensive coin information

## Best Practices Demonstrated

- **Separation of Concerns**: Clear boundaries between data, business logic, and UI
- **Protocol-Oriented Design**: Flexible and testable networking layer
- **Error Handling**: Comprehensive error management throughout the app
- **Modern Swift**: Leveraging latest language features and concurrency patterns
- **Performance Optimization**: Smart caching to minimize network requests

## Contributing

This project is designed for educational purposes. Feel free to fork, experiment, and enhance the codebase as part of your iOS development learning journey.

## License

This project is available under the MIT License. See the [LICENSE](LICENSE) file for more information.

---

Built as a learning resource for iOS networking and modern Swift development patterns.