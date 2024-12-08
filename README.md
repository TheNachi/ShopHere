# ShopHere
A simple E-Commerce Application

## Project Overview
ShopHereApp is a SwiftUI-based e-commerce application designed to showcase products from a remote JSON-based API. The app provides an intuitive UI for browsing products, viewing details, and managing a shopping cart. It demonstrates modern development principles such as MVVM architecture, dependency injection, and reactive programming.

## Features
### Product List:
Fetches and displays products dynamically from a mock API.
Includes a search bar for filtering products based on user input.

### Product Details:
Displays detailed information about a selected product, including its name, description, price, and image.
Offers "Add to Cart" and "Buy Now" functionality (with "Buy Now" marked as a placeholder for a future feature).

### Cart Management:
Tracks items added or removed from the shopping cart.
Displays the total count of cart items in the navigation bar.

### Navigation:
Utilizes a custom Router class for managing transitions between product list and detail views.

### Error Handling:
Displays user-friendly alerts for errors such as API failures or incomplete features.

## Installation

Clone the repository:

    git clone https://github.com/TheNachi/ShopHere.git

Navigate to the project directory:

    cd ShopHereApp

Install the dependencies using CocoaPods:

    pod install

Open the generated .xcworkspace file in Xcode:

    open ShopHereApp.xcworkspace


Ensure your environment is configured for iOS 15.0 or later.
Build and run the project on the simulator or a physical device.

## Testing
The project includes unit tests to validate the functionality of key components, particularly the ProductListViewModel and Router. These tests ensure that the app behaves correctly in various scenarios, including successful API responses and error handling.

### How to Run Tests

#### Open the Workspace:
Ensure you have opened the project using the .xcworkspace file (not .xcodeproj) in Xcode.

#### Select the Testing Scheme:
In Xcode, click on the scheme selector (next to the run/stop buttons) and ensure the ShopHereApp scheme is selected.

#### Run All Tests:
Press Command + U or go to the menu and select Product > Test. Xcode will execute all unit tests and display the results in the Test Navigator.

#### Run Specific Tests:
Open the Test Navigator (Command + 6).
Select a specific test or test class, and click the run icon next to it.

#### Check Test Results:
Review test results in the Test Navigator or the Debug Console. Any failing tests will be highlighted.

## Design Choices
### Architecture
MVVM: Separates the UI (Views) from business logic (ViewModels), improving testability and maintainability.
Dependency Injection: Uses the Swinject library to manage dependencies, ensuring clean and modular code.

### Third-Party Libraries
Combine Framework: Enables reactive programming, making API calls and data handling more efficient.
Swinject: Simplifies dependency injection, making the app easily extendable.

### UI Design
SwiftUI: Ensures modern and declarative UI code with dynamic views.
AsyncImage: Handles asynchronous image loading with a fallback placeholder.

## Performance Optimization
### Lazy Loading:
Uses AsyncImage to load product images only when needed, reducing initial load time.

### Combine Pipeline:
Offloads API responses to a background thread for decoding, ensuring the main thread remains responsive.

### Efficient State Management:
Avoids excessive re-renders by limiting the use of @Published to critical properties in ProductListViewModel.

### Search Optimization:
Filters products in-memory rather than making additional API calls for search functionality.

### Reusable Components:
Components like SearchBarView and ProductDetailView are designed for reuse across potential new features.

## Known Limitations and Future Enhancements
### Persistent Cart:
The cart is not persisted across app sessions. This could be addressed using Core Data or local file storage.

### API Integration:
In a production setting, the API should include error codes and pagination for handling large datasets.

### Feature Completeness:
"Buy Now" and checkout functionalities are currently placeholders.

## Usage
### Run the App:
Launch the app and explore the product list.
### Search Products:
Use the search bar to filter products.
### View Details:
Tap on a product to view its details.
### Cart Management:
Add products to the cart from the product detail view.
Navigate back to the product list to see the updated cart count.