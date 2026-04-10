import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state.dart';

// final processNotifierProvider = NotifierProvider<ProcessNotifier, ProcessState>(ProcessNotifier.new);

// // This is the actual notifier that manages the state
// class ProcessNotifier extends Notifier<ProcessState> {
//   @override
//   ProcessState build() {
//     return ProcessState();
//   }

//   // Main async process with step tracking
//   Future<void> runLongProcess() async {
//     try {
//       // Step 1: Fetch user
//       state = state.copyWith(
//         currentStep: ProcessStep.fetchingUser,
//         hasError: false,
//         errorMessage: null,
//       );
      
//       final user = await _fetchUserFromApi();
//       print('✅ User fetched: ${user.name}');
      
//       // Step 2: Fetch posts (depends on user)
//       state = state.copyWith(currentStep: ProcessStep.fetchingPosts);
//       final posts = await _fetchPostsFromApi(user.id);
//       print('✅ Posts fetched: ${posts.length} posts');
      
//       // Step 3: Save to storage
//       state = state.copyWith(currentStep: ProcessStep.savingToStorage);
//       await _saveToLocalStorage(user, posts);
//       print('✅ Saved to storage');
      
//       // Complete!
//       state = state.copyWith(currentStep: ProcessStep.completed);
      
//     } catch (e) {
//       // Capture which step failed with the error
//       state = ProcessState.error(state.currentStep, e.toString());
//       print('❌ Failed at ${state.currentStep}: $e');
//     }
//   }
  
//   // Reset the process
//   void reset() {
//     state = ProcessState();
//   }
  
//   // --- Mock implementations (replace with real API calls) ---
//   Future<User> _fetchUserFromApi() async {
//     await Future.delayed(const Duration(seconds: 2));
//     // Simulate network error occasionally for testing
//     // throw Exception('Network connection failed');
//     return User(id: '123', name: 'John Doe');
//   }
  
//   Future<List<Post>> _fetchPostsFromApi(String userId) async {
//     await Future.delayed(const Duration(seconds: 2));
//     if (userId.isEmpty) throw Exception('Invalid user ID');
//     return [
//       Post(id: '1', title: 'First post'),
//       Post(id: '2', title: 'Second post'),
//     ];
//   }
  
//   Future<void> _saveToLocalStorage(User user, List<Post> posts) async {
//     await Future.delayed(const Duration(seconds: 1));
//     // Here you would use SharedPreferences, Hive, SQLite, etc.
//     print('Saving ${posts.length} posts for user ${user.name}');
//   }
// }

// Model classes
class User {
  final String id;
  final String name;
  User({required this.id, required this.name});
}

class Post {
  final String id;
  final String title;
  Post({required this.id, required this.title});
}