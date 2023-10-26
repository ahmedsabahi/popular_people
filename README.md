# Flutter MovieDB App

![Flutter](https://img.shields.io/badge/Flutter-3.13.8-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.1.4-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

This Flutter app allows users to explore popular people in the movie industry and view their details, images, and save them locally on their phone. It uses the themoviedb.org API to fetch data.

## Table of Contents

- [Features](#features)
- [State Management](#state-management)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [API Key](#api-key)
- [Contributing](#contributing)

## Features

1. Displaying a list of popular people (actors, directors, etc.) with infinite scrolling.
2. Details view for each person with basic information and a grid view of their images.
3. Viewing images in their original size and the ability to save them locally on the phone.

## State Management

I am using **Riverpod** to manage the application's state. Riverpod is a powerful state management package for Flutter that provides a simple and intuitive way to handle state.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Flutter and Dart are installed on your system. [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- You have an account on themoviedb.org to obtain an API key.

## Installation

To install this project, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/ahmedsabahi/popular_people.git

2. Change into the project directory:
   
    ```bash
    cd your-repo
   
3. Install dependencies:
   
    ```bash
    flutter pub get
   
## Usage

To run the app, execute the following command:

     flutter run

The app will launch, and you can explore popular people, view their details, and save images to your phone.

## API Key

To access the themoviedb.org API, you need to obtain an API key. Add your API key in the lib/constants.dart file:

    const String apiKeyAuth = 'YOUR_API_KEY';

## Contributing

We welcome contributions! If you'd like to contribute to this project, please follow these steps:

1. Fork the project.

2. Create a new branch for your feature:

   ```bash
   git checkout -b feature-your-feature-name

3. Commit your changes: 

   ```bash
   git commit -m 'Add new feature'

4. Push to your branch:

   ```bash
   git push origin feature-your-feature-name
   
5. Submit a pull request.

