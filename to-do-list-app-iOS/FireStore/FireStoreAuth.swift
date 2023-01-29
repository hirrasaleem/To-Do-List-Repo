//
//  FireStoreAuth.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 28/01/2023.
//

import Foundation
import FirebaseAuth
import Firebase
extension FireStoreManager{
    func signUp(email: String, password: String, completionBlock: @escaping (_ success: Bool, _ message: String) -> Void) {
        if !Reachability.isConnectedToNetwork() {
            completionBlock(false, "Please connect with internet first")
         }
            Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
                if let user = authResult?.user {
                    print(user)
                    completionBlock(true, "")
                } else {
                    completionBlock(false, error?.localizedDescription ?? "")
                }
            }
        }
    

    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool, _ message: String) -> Void) {
        
        if !Reachability.isConnectedToNetwork() {
            completionBlock(false, "Please connect with internet first")
         }
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if error != nil{
                completionBlock(false, error?.localizedDescription ?? "")
            } else {
                completionBlock(true, "")
            }
        }
    }
}
