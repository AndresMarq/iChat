//
//  DatabaseController.swift
//  iChat
//
//  Created by Andres Marquez on 2022-08-17.
//

import Foundation
import FirebaseDatabase

final class DatabaseController {
    
    static let shared = DatabaseController()
    private let database = Database.database().reference()
    
    // Add new users to Firebase database
    public func addUser(user: User) {
        database.child(user.databaseEmail).setValue([
            "firstName": user.firstName,
            "lastName": user.lastName
        ])
    }
    
    // Ensures unique email for new users, return true if e-mail already exists
    public func userExists(email: String, completion: @escaping((Bool) -> Void)) {
        let databaseEmail = email.replacingOccurrences(of: ".", with: "")
        
        database.child(databaseEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String == nil else {
                completion(true)
                return
            }
            completion(false)
        })
    }
}
