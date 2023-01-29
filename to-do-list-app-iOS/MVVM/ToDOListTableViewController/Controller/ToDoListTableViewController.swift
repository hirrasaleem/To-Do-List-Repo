//
//  ToDOListTableViewController.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 27/01/2023.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth
import FirebaseFirestore

class ToDOListViewController: BaseViewController {
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var datePicker:UIDatePicker = UIDatePicker()
    let toolBar = UIToolbar()
    
    private var viewModel : ToDoListModelView!
    // MARK: Add

    @IBAction func addItemBarButton(_ sender: UIBarButtonItem) {
        showAddToDOView()
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
    }
  
    override func configureView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.bindingViewModel()
        self.fetchData()
        
    }
    func bindingViewModel(){
        self.viewModel = ToDoListModelView()
        tableView.register(UINib(nibName: self.viewModel.cellIdentifierName, bundle: nil), forCellReuseIdentifier: self.viewModel.cellIdentifierName)
        fetchData()

    }
    func fetchData(){
        self.noDataLabel.text =  self.viewModel.loadingText
        self.viewModel.bindTaskViewModelToController = { obj, message, isSuccess  in
            DispatchQueue.main.async {
                if isSuccess{
                    self.noDataView.isHidden = true
                    if obj.count == 0{
                        self.noDataLabel.text =  self.viewModel.noDataText
                        self.noDataView.isHidden = false
                        self.tableView.alpha = 0
                    } else{
                        self.noDataView.isHidden = true
                        self.tableView.alpha = 1
                    }
                }else{
                    self.noDataLabel.text =  self.viewModel.noDataText

                    self.noDataView.isHidden = false
                }
                self.tableView.reloadData()
            }
        }
        self.viewModel.loadTaskData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func showAddToDOView(){
        let storyBoard = UIStoryboard(name: StoryBoard.main.rawValue, bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: StoryBoardID.addTask.rawValue) as! AddTaskViewController
        mainViewController.modalPresentationStyle = .fullScreen
        mainViewController.navTitle =  self.viewModel.addText
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    func showEditToDOView(_ model: ToDoModel){
        let storyBoard = UIStoryboard(name: StoryBoard.main.rawValue, bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: StoryBoardID.addTask.rawValue) as! AddTaskViewController
        mainViewController.modalPresentationStyle = .fullScreen
        mainViewController.toDoModel =  model
        mainViewController.navTitle =  self.viewModel.editText
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    
}
extension ToDOListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table Data Source
    
    // Provide the number of sections and rows in the data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.modelData.count
    }
    
    // Compose the cell with data from the source for a particular row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.viewModel.cellIdentifierName, for: indexPath) as! ToDOIdeaTableViewCell
        cell.toDOIdea = self.viewModel.modelData[indexPath.row]
        return cell
    }
    
    // Inform the view that a user can edit a particular row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .normal,
            title: self.viewModel.deleteText,
            handler: { (action, view, completion) in
                self.viewModel.remove(indexPath.row)
                completion(true)
            })
        deleteAction.backgroundColor = .red
        let editAction = UIContextualAction(
            style: .normal,
            title: self.viewModel.editText,
            handler: { (action, view, completion) in
                //do what you want here
                self.showEditToDOView(self.viewModel.modelData[indexPath.row])

                completion(true)
            })
        
        deleteAction.backgroundColor = .gray
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    // Inform the view that a user can move a particular row
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
