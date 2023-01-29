//
//  TabBarPage.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 29/01/2023.
//

import Foundation
enum TabBarPage {
    case account
    case list

    init?(index: Int) {
        switch index {
        case 0:
            self = .account
        case 1:
            self = .list

        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .account:
            return "Account"
        case .list:
            return "To-Do List"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .account:
            return 0
        case .list:
            return 1
        }
    }

    // Add tab icon value
    
    // Add tab icon selected / deselected color
    
    // etc
}
