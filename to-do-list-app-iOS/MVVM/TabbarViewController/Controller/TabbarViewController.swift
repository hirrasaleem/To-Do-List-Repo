//
//  TabbarViewController.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 29/01/2023.
//

import UIKit
protocol TabbarControllerDelegate: AnyObject {
    func showAccount()
}
extension TabbarControllerDelegate{
    func showAccount(){}
}
class TabbarViewController: UITabBarController {
    public weak var tabbarDelegate : TabbarControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
