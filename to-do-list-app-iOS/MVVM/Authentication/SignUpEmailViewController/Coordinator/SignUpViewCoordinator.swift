//
//  SignUpViewCoordinator.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 29/01/2023.
//

import UIKit
class SignUpViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController:UINavigationController
    
    // We use this delegate to keep a reference to the parent coordinator
    weak var delegate: BackToHomeViewControllerDelegate?

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let detailViewController : SignUpEmailViewController = SignUpEmailViewController()
        detailViewController.delegate = self
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
}

extension SignUpViewCoordinator : SignUpViewControllerDelegate {
    func navigateToTabbarPage(_ stroyBoardID: StoryBoardID, storyBoard: StoryBoard) {
        let storyBoard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: stroyBoardID.rawValue)
        mainViewController.modalPresentationStyle = .fullScreen
        self.navigationController.present(mainViewController, animated: true)
    }
    
    
    func nextToSignInPage() {
        self.navigationController.popViewController(animated: true)
    }
}
