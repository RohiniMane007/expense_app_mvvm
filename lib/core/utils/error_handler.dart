// lib/core/utils/error_handler.dart
import 'dart:async';
import 'dart:io';

class ErrorHandler {
  // Handles general errors (network, format, HTTP, etc.)
  static String handleError(Object error) {
    // Network-related errors (e.g., no internet, timeout)
    if (error is SocketException) {
      return 'Network error: Please check your internet connection.';
    } else if (error is TimeoutException) {
      // Timeout errors (API call timeout)
      return 'Request timeout: The server took too long to respond.';
    } else if (error is HttpException) {
      // HTTP error codes (e.g., 404, 500)
      return 'HTTP error: ${error.message}';
    } else if (error is FormatException) {
      // Format error (e.g., JSON parsing error)
      return 'Data error: Failed to decode the response from the server.';
    } else if (error is Exception) {
      // General exceptions (any unhandled error)
      return 'An unexpected error occurred: ${error.toString()}';
    } else {
      // Catch-all for other unknown errors
      return 'An unknown error occurred. Please try again later.';
    }
  }

  // Log errors for external debugging or analytics
  static void logError(Object error) {
    // Here you could use services like Firebase Crashlytics, Sentry, etc.
    // Example: FirebaseCrashlytics.instance.recordError(error, StackTrace.current);
    print('Logged error: $error');
  }
}
