//
//  AccountViewController.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 27/01/2023.
//

import FirebaseAnalytics
import FirebaseAuth
import FirebaseStorage
import UIKit

class AccountViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Segues
    
    @IBOutlet weak var signOutButton: UIButton!
    
    
    
    // MARK: View Lifecycle
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signOutButton.layer.cornerRadius = 5
        Auth.auth().addStateDidChangeListener({(auth, user) in
            
            if user == nil {
                self.presentViewController(.signIn, storyBoard: .auth)
                
                // If there are issues with views flickering then move to AppDelegate and switch window?.rootViewController
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // If a user is logged in, setup the view with name, profile image, et al
        if let user = Auth.auth().currentUser {
            nameLabel.text = user.displayName ?? user.email
        }
        
        
    }

    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Log Out of Sample App?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Log Out", style: .default, handler: {(action) in
            do {
                try Auth.auth().signOut()
                // TODO: refs.keepSynced = false for this user
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            self.presentViewController(.signIn, storyBoard: .auth)
        }))
        self.present(alert, animated: true, completion: {() -> Void in })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



