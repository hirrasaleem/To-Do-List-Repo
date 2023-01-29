//
//  SignInViewCoordinator.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 29/01/2023.
//

import UIKit
class SignInViewCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var type: CoordinatorType
    
    
    var childCoordinators: [Coordinator] = []
    
    unowned var navigationController:UINavigationController
    
    // We use this delegate to keep a reference to the parent coordinator

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let detailViewController : SignInEmailViewController = SignInEmailViewController()
        detailViewController.delegate = self
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
}

extension SignInViewCoordinator : SignInViewControllerDelegate {
    func navigateToSignUpPage(_ stroyBoardID: StoryBoardID, storyBoard: StoryBoard) {
        let storyBoard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: stroyBoardID.rawValue)
        mainViewController.modalPresentationStyle = .fullScreen
        self.navigationController.present(mainViewController, animated: true)
    }
    
    func navigateToForgetPasswordPage(_ stroyBoardID: StoryBoardID, storyBoard: StoryBoard) {
        let storyBoard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: stroyBoardID.rawValue)
        mainViewController.modalPresentationStyle = .fullScreen
        self.navigationController.present(mainViewController, animated: true)
    }
    
    
    func navigateToTabbarPage(_ stroyBoardID: StoryBoardID, storyBoard: StoryBoard) {
        let storyBoard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: stroyBoardID.rawValue)
        mainViewController.modalPresentationStyle = .fullScreen
        self.navigationController.present(mainViewController, animated: true)
    }
    
  
    
    
  
}
