//
//  AuthService.swift
//  MotaNet
//
//  Created by sam hastings on 09/08/2024.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore


@Observable class AuthService {
    
    // This will govern view routing/presentation logic
    
    var userSession: FirebaseAuth.User?
    var currentUser: User?
    private let auth = Auth.auth()
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    static let shared = AuthService()
    
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = auth.addStateDidChangeListener { auth, user in
                self.userSession = user
                if self.userSession != nil {
                    Task { try await self.loadUserData() }
                }
            }
        }
    }
    
    init() {
        // performs check to see if user is logged into our app.
        registerAuthStateHandler()
    }
    
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: Failed to log in user with error \(error.localizedDescription)")
        }
    }
    
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            self.userSession = result.user
            await self.uploadUserData(uid: result.user.uid, username: username, email: email)
        } catch {
            print("DEBUG: Failed to register user with error \(error.localizedDescription)")
        }
    }
    
    /// Fetch and load user sata from the firestore database.
    func loadUserData() async throws {
        //registerAuthStateHandler()
        guard let currentUid = self.userSession?.uid else { return }
        //let snapshot = try await Firestore.firestore().collection("users").document(currentUid).getDocument()
        currentUser = try await UserService.fetchUser(withUid: currentUid)
    }
    
    func signout() {
        try? auth.signOut()
        self.userSession = nil
        self.currentUser = nil
    }
    
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
