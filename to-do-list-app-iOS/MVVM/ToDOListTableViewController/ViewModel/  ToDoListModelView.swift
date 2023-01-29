//
//    ToDoListModelView.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 28/01/2023.
//

import Foundation
import UIKit

struct Constants{
    static let loadingText = "Loading...."
    static let noDataText = "No Data Found"
    static let editText = "Edit"
    static let deleteText = "Delete"
    static let addText = "Add"
}

class ToDoListModelView: NSObject {
    let loadingText = Constants.loadingText
    let noDataText = Constants.noDataText
    let editText = Constants.editText
    let deleteText = Constants.deleteText
    let addText = Constants.addText
    var cellIdentifierName = "ToDOIdeaTableViewCell"
    var isSuccess = false
    var errorString = ""
    let manager = FireStoreManager()

    private(set) var listViewModel : [ToDoModel]!{
        didSet {
            self.bindTaskViewModelToController(self.listViewModel, errorString, isSuccess)
        }
    }
    var bindTaskViewModelToController : (([ToDoModel], String, Bool) -> Void) = {_,_,_  in }
    
    var modelData = [ToDoModel]()
    
    override init() {
        super.init()
    }
    func loadTaskData(){
        manager.fetch { data, isTrue, msg in
            self.modelData = data
            self.isSuccess = isTrue
            self.errorString = msg
            self.listViewModel = self.modelData
        }
    }
    
    func remove(_ index: Int){
        let id = self.modelData[index].id ?? ""
        manager.remove(id: id) { isTrue, msg in
            self.isSuccess = isTrue
            self.errorString = msg
            if isTrue{
                self.modelData.remove(at: index)
            }
            self.listViewModel = self.modelData
        }
    }
}
