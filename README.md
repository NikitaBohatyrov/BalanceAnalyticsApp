# iOS Balance Tracker App

## Objective

The **iOS Balance Tracker App** allows users to track and visualize their balance over different periods (weekly, monthly, yearly). It uses **SwiftUI** for the user interface, **The Composable Architecture (TCA)** for state management, and the **Charts** library for graphical representation of the balance changes. The app enables users to:

- View their balance over specific time periods (week, month, year).
- Interact with a graph displaying balance changes.
- Select specific days on the graph for detailed information.
  
This project was built with a focus on **modular architecture**, **clean code practices**, and **user-friendly UI design**.

## Challenges

During the development of the app, I encountered several challenges, including:

### 1. **Integrating The Composable Architecture (TCA)**

TCA provides a functional programming approach, which was a bit tricky to integrate. Understanding how to manage state, actions, and effects with TCA, while ensuring the app stayed modular and scalable, took time.

### 2. **Charts Library Customization**

While the **Charts** library is highly powerful, customizing the graph to fit the design requirements, especially handling user interactions (such as selecting a specific day), required a deep dive into the library's documentation. I had to figure out how to link data points to specific dates and update the UI accordingly.

### 3. **Handling Data Across Different Time Periods**

Implementing the logic to calculate balances over different time periods (weekly, monthly, yearly) and then accurately displaying them on the graph was a bit tricky, especially when considering edge cases like leap years or weeks that span over two months.

## Installation Guide

To set up the **iOS Balance Tracker App** on your local machine, follow the steps below:

```
git clone https://github.com/NikitaBohatyrov/BalanceAnalyticsApp.git
cd balanceAnalyticsApp
open balanceAnalyticsApp.xcodeproj
select file > add package dependencies
select add Local
select AnalyticsApp folder from project directory
after fetching set target membersip
Add AppCore and AppView to project target
press add package
change signing sertificate in project settings
build and run
```

### Solution Details

App was created according pointFree recomendations of creating modular architecture with TCA.

All of the app Content stored in AnalyticsApp/Sources

It provides complex code separation which can ease problems like cross-platform development and separation of development process, in case of production better to store such package separately and compare hash.

### Prerequisites

- **Xcode 15** or later (iOS 17 compatibility)
- **Iphone** only version

### Possible improvements
1) by spending more time I would take care of Chart and more Logics segregation using scoped reducers.
2) I found out slight inconcistency in design related to day selection in year time gap ( there is 120 dots which correlates incorrectly with number of days in a year ) for this reason I did not make a white bar connected to circle indicating day selection.
3) according time gap selection like month I would create CalendarManager to add calendar based number of days in a gap.
4) I would add Haptic feedback for general actions to enhance user experience.
#### I would be pleased to answer any questions about the project and problem solution.
