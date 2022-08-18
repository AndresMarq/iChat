//
//  User.swift
//  iChat
//
//  Created by Andres Marquez on 2022-08-17.
//

import Foundation

struct User {
    let firstName: String
    let lastName: String
    let email: String
    //let profilePicUrl: String
    
    // Child in database cannot contain ".", thus e-mail is modified in computed property below
    var databaseEmail: String {
        let databaseEmail = email.replacingOccurrences(of: ".", with: "")
        return databaseEmail
    }
}
