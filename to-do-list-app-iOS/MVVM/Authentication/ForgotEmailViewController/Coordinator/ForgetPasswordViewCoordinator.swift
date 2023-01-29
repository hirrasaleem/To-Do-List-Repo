//
//  ForgetPasswordViewCoordinator.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 29/01/2023.
//

import UIKit

class ForgetPasswordViewCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var type: CoordinatorType
    
    var childCoordinators: [Coordinator] = []
    
    unowned var navigationController:UINavigationController
    
    // We use this delegate to keep a reference to the parent coordinator
    weak var delegate: BackToHomeViewControllerDelegate?

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let detailViewController : ForgotEmailViewController = ForgotEmailViewController()
        detailViewController.delegate = self
        self.navigationController.pushViewController(detailViewController, animated: true)
    }
}

extension ForgetPasswordViewCoordinator : ForgotViewControllerDelegate {
    
    func nextToSignInPage() {
        self.navigationController.popViewController(animated: true)
    }
}
