//
//  AddTaskViewController.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 28/01/2023.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth
import FirebaseFirestore

class AddTaskViewController: BaseViewController {
    @IBOutlet weak var tappedButton: UIButton!
    @IBOutlet weak var titleTextField : UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dueDateTextField : UITextField!
    var placeholderLabel : UILabel!
    var toDOItemsCollection: CollectionReference?
    var toDoModel: ToDoModel?
    let manager = FireStoreManager()
    var navTitle: String?
    var datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func configureView() {
        self.titleLabel.text = navTitle
        self.setEditValues()
        self.setupTextView()
        self.dueDateTextField.setDatePickerAsInputViewFor(target: self, selector: #selector(dateSelected))
        self.tappedButton.setTitle(navTitle, for: .normal)
    }
    
    func setEditValues(){
        guard let model = self.toDoModel else {
            return
        }
        self.titleTextField.text =  model.title
        self.descriptionTextView.text =  model.description
        self.dueDateTextField.text =  model.dueDate
        
    }
    @objc func dateSelected() {
        if let datePicker = self.dueDateTextField.inputView as? UIDatePicker {
            self.datePicker = datePicker
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .medium
            self.dueDateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.dueDateTextField.resignFirstResponder()
    }
    func setupTextView(){
        if descriptionTextView.text.isEmpty {
            descriptionTextView.delegate = self
            placeholderLabel = UILabel()
            placeholderLabel.text = "Description"
            placeholderLabel.font = .italicSystemFont(ofSize: (descriptionTextView.font?.pointSize)!)
            placeholderLabel.sizeToFit()
            descriptionTextView.addSubview(placeholderLabel)
            placeholderLabel.frame.origin = CGPoint(x: 5, y: (descriptionTextView.font?.pointSize)! / 2)
            placeholderLabel.textColor = .tertiaryLabel
            placeholderLabel.isHidden = !descriptionTextView.text.isEmpty
        }
    }
    
    @IBAction func tappedAddTask(_ sender: UIButton) {
        
        // Log an event with Firebase Analytics
        var description =  descriptionTextView.text ?? ""
        if descriptionTextView.textColor == .lightGray{
            description = ""
        }else{
            description = descriptionTextView.text
        }
        if validation(string: titleTextField.text ?? ""){
            alert("Enter Title")
        }else if validation(string: description){
            alert("Add Description")
        }else if validation(string: dueDateTextField.text ?? ""){
            alert("Add Due Date")
        }else{
            guard let currUser = Auth.auth().currentUser else {
                return
                
            }
            let collection = "users/\(currUser.uid)/toDOlists"
            self.toDOItemsCollection = Firestore.firestore().collection(collection)
            self.toDOItemsCollection?.document().setData(["title": titleTextField.text ?? "", "description": descriptionTextView.text ?? "",  "dueDate": dueDateTextField.text ?? ""])
            manager.addUpdateItem(idUpdate: self.toDoModel?.id, title: titleTextField.text ?? "", description: descriptionTextView.text ?? "", dueDate: dueDateTextField.text ?? "", date: self.datePicker.date) { msg, isSuccess in
                
                self.navigationController?.popToRootViewController(animated: false)
            }
            
        }
        self.navigationController?.popToRootViewController(animated: false)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
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
extension AddTaskViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
