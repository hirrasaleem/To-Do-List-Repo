//
//  ToDoModel.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 29/01/2023.
//

import Foundation
struct ToDoModel: Codable{
    var title: String?
    var description: String?
    var dueDate: String?
    var id: String?
    init(title: String, description: String, dueDate: String, id: String)  {
        self.title = title
        self.dueDate = dueDate
        self.description = description
        self.id = id
    }
}
