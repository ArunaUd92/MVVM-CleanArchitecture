# iOS App Template with Clean Architecture and MVVM

This is a template iOS application built using Clean Architecture and MVVM principles, utilizing SwiftUI and Combine. The project includes DIContainer, FlowCoordinator, DTO, Response Caching, and more.

## Features

- Clean Architecture and MVVM Design
- SwiftUI for UI Components
- Combine for Reactive Programming
- Dependency Injection
- Network Layer with Alamofire
- Unit Testing with XCTest
- Mock Implementations for Testing

## Project Structure

```plaintext
MVVM+CleanArchitecture/
├── MVVM+CleanArchitecture.swift
├── Domain/
│   ├── Entities/
│   │   └── User.swift
│   ├── Protocols/
│   │   └── UserFetchDelegate.swift
│   ├── Repositories/
│   │   └── UserRepository.swift
│   ├── UseCases/
│   │   └── FetchUsersUseCase.swift
├── Data/
│   ├── Network/
│   │   └── APIService.swift
│   ├── Repositories/
│   │   └── UserRepositoryImpl.swift
├── Presentation/
│   ├── ViewModels/
│   │   └── UserViewModel.swift
│   └── Views/
│       ├── UserView.swift
│       └── UserDetailView.swift
└── Tests/
    ├── MockUserRepository.swift
    ├── MockFetchUsersUseCase.swift
    ├── MockUserFetchDelegate.swift
    └── UserViewModelTests.swift
```

## Detailed Explanation

### Presentation Layer

#### Views:
* **UserView:** Displays a list of users with an interactive UI, utilizing SwiftUI's NavigationView, List, and ProgressView.
* **UserDetailView:** Shows detailed information about a selected user, enhanced with attractive typography and layout elements.

#### ViewModels:

* **UserViewModel:** Manages UI state, fetches user data through the FetchUsersUseCase, and handles user interactions, updating the view accordingly. Utilizes Combine to reactively bind data changes.

### Domain Layer

#### Protocols:

* **UserFetchDelegate:** Defines contracts for operations, ensuring communication between layers without specific implementation details.
Use Cases:

* **FetchUsersUseCase:** Encapsulates the business logic for fetching users, interacting with repositories to obtain data.
Entities:

* **User:** Represents core business objects with properties id, name, and email.
Repositories:

* **UserRepository:** Defines interfaces for data operations, abstracting data access from the Domain Layer.

### Data Layer

#### Network:

* **APIService:** Handles network requests using Alamofire, providing a generic method for making API calls and managing network errors.
Repositories:

* **UserRepositoryImpl:** Implements the UserRepository interface, fetching data from the network and mapping it to domain entities using DTOs.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.