import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Singleton instance
  AuthService._privateConstructor();
  static final AuthService _instance = AuthService._privateConstructor();
  factory AuthService() {
    return _instance;
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      //print(e.toString());
      rethrow;
    }
  }

  Future<User?> signUp(String email, String password, String name) async {
    try {
      // Check if the user already exists
      QuerySnapshot userQuery = await _db.collection('users').where('email', isEqualTo: email).get();
      if (userQuery.docs.isNotEmpty) {
        print('User already exists');
        throw Exception('User with this email already exists');
      }

      // Create a new user
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      if (user != null) {
        await _db.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
        });
      }
      return user;
    } catch (e) {
      //print(e.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> getCurrentUserId() async {
    final User? loggedUser = _auth.currentUser;

    if (loggedUser != null) {
      // User is signed in
      final String uid = loggedUser.uid;
      return await getUserByAuthId(uid);
    } else {
      // User is signed out
      return null;
    }
  }

  Future<String?> getUserByAuthId(String authId) async {
    try {
      // Query the collection to find a document where the 'authId' field matches the provided authId
      DocumentSnapshot snapshot = await _db.collection('users').doc(authId).get();

      if (snapshot.exists) {
        // Return the document ID of the first document found
        return snapshot.id;
      } else {
        print("No user found for the given authId.");
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  // Future<User?> signInWithGoogle() async {
  //   try {
  //     // Trigger the Google authentication flow
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) {
  //       // User canceled the sign-in
  //       return null;
  //     }

  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  //     // Create a new credential
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     // Sign in to Firebase with the Google credential
  //     UserCredential result = await _auth.signInWithCredential(credential);
  //     User? user = result.user;

  //     if (user != null) {
  //       // Check if the user is new and create a Firestore document if so
  //       DocumentSnapshot userDoc = await _db.collection('users').doc(user.uid).get();
  //       if (!userDoc.exists) {
  //         String name = user.displayName!.split(' ')[0];
  //         String surname = user.displayName!.split(' ')[1];
  //         // If the user does not exist in Firestore, create a new user document
  //         await _db.collection('users').doc(user.uid).set({
  //           'name': name,
  //           'surname': surname,
  //           'email': user.email,
  //           'profileVisibility': false,
  //           'bio': '',
  //           'birthDate': DateTime.now(),
  //           'location': '',
  //           'userType': 'pet_owner',
  //           'profilePictureUrl': '',
  //           'sidebarImage': '',
  //           'phoneDetails': {
  //             'phoneNumber': '',
  //             'isoCode': '',
  //             'dialCode': '',
  //           },
  //           'preferences': {
  //             'Colours': {
  //               'BackgroundColour': 4278190080,
  //               'CardColour': 4279505940,
  //               'NavbarTextColour': 4294967295,
  //               'PrimaryColour': 4283302026,
  //               'SecondaryColour': 4279522048,
  //               'TextColour': 4294967295,
  //             },
  //             'themeMode': 'light',
  //             'usingDefaultImage': true,
  //             'usingImage': false
  //           },
  //         });
  //       }
  //     }

  //     return user;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
}
