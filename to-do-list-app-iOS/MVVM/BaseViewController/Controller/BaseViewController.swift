//
//  BaseViewController.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 27/01/2023.
//

import UIKit
enum StoryBoard: String {
    case main = "Main"
    case auth = "Authentication"
}
enum StoryBoardID: String {
    case signIn = "SignIn"
    case forget = "Forget"
    case signUp = "SignUp"
    case tabbar = "tabbar"
    case addTask = "AddTask"
    
}
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.configureView()
    }
    func configureView(){
        
    }
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func presentViewController(_ stroyBoardID: StoryBoardID, storyBoard: StoryBoard) {
        let storyBoard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: stroyBoardID.rawValue)
        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: true)
    }
    func validation(string: String) -> Bool{
        if string.isEmpty {
            return true
        } else {
            return false
        }
    }
    func alert(_ description: String){
        let alertController = UIAlertController(title: "Alert", message: description, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
