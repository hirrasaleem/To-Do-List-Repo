//
//  AccountViewCoordinator.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 29/01/2023.
//

import UIKit

protocol BackToHomeViewControllerDelegate: AnyObject {
    
    func navigateBackToHomePage()
    
}
class AccountViewCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var type: CoordinatorType
    
    
    var childCoordinators: [Coordinator] = []
    weak var delegate: BackToHomeViewControllerDelegate?

    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let firstViewController : AccountViewController = AccountViewController()
        firstViewController.delegate = self
        self.navigationController.viewControllers = [firstViewController]
    }
}

extension AccountViewCoordinator: AccountViewControllerDelegate {
    
    func navigateToSignInPage(_ stroyBoardID: StoryBoardID, storyBoard: StoryBoard) {
        let storyBoard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: stroyBoardID.rawValue)
        mainViewController.modalPresentationStyle = .fullScreen
        self.navigationController.present(mainViewController, animated: true)
    }
}

extension AccountViewCoordinator: BackToHomeViewControllerDelegate{
    func navigateBackToHomePage() {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
    
}
