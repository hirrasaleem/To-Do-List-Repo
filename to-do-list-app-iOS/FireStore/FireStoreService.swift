//
//  FireStoreService.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 28/01/2023.
//
//

import Foundation
import FirebaseAuth
import Firebase
class FireStoreManager {
    // MARK: Add & Update Item
    func addUpdateItem(idUpdate: String?, title: String, description: String, dueDate: String, date: Date, completionHandler:@escaping(String, Bool) -> Void){
        
        var ref = Database.database().reference()
        var id = ref.childByAutoId().key ?? ""
        if idUpdate != nil {
            id = idUpdate ?? ""
        }
        let BodyDic = ["title":title, "description": description, "dueDate": dueDate, "id": id] as [String : Any]
        ref = ref.child(Auth.auth().currentUser?.uid ?? "").child("Tasks").child(id)
        if !Reachability.isConnectedToNetwork() {
            completionHandler("Check internet connectivity", false)
        }
        ref.updateChildValues(BodyDic){(error:Error?, ref: DatabaseReference) in
            DispatchQueue.main.async {
                if let error = error{
                    
                    completionHandler(error.localizedDescription, false)
                }
                else{
                    Notifications.init().createNotificaion(id: id, title: title, body: description, date: date)
                    completionHandler("Item Created", true)
                }
            }
            
        }
    }
    
    
    
    // MARK: Fetch Items
    func fetch(completionHAndler:@escaping([ToDoModel], Bool, String)->Void){
        let userId = Auth.auth().currentUser?.uid ?? ""
        var taskArray = [ToDoModel]()
        let ref = Database.database().reference()
        if !Reachability.isConnectedToNetwork() {
            completionHAndler(taskArray, false, "Please connect with internet first")
        }
        ref.child(userId).child("Tasks").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let objectDic = snapshot.value as? NSDictionary{
                for obj in objectDic{
                    
                    if let taskObj = obj.value as? NSDictionary {
                        let title = taskObj["title"] as? String ?? ""
                        let description = taskObj["description"] as? String ?? ""
                        let dueDate = taskObj["dueDate"] as? String ?? ""
                        let id = taskObj["id"] as? String ?? ""
                        
                        let modelObj = ToDoModel(title: title, description: description, dueDate: dueDate, id: id)
                        taskArray.append(modelObj)
                    }
                }
                completionHAndler(taskArray, true, "tasks found")
            }else{
                completionHAndler(taskArray, false, "No Task found")
            }
            
        })
    }
    
    // MARK: Remove Item
    func remove(id: String, completionHAndler:@escaping(Bool, String)->Void){
        if !Reachability.isConnectedToNetwork() {
            completionHAndler(false, "Please connect with internet first")
        }
        var ref = Database.database().reference()
        ref = ref.child(Auth.auth().currentUser?.uid ?? "").child("Tasks").child(id)
        ref.removeValue { error,db  in
            if error != nil {
                completionHAndler(false, error?.localizedDescription ?? "")
            }else{
                Notifications.init().remove(id: id)
                completionHAndler(true, "item deleted")
            }
        }
        
    }
    
}
