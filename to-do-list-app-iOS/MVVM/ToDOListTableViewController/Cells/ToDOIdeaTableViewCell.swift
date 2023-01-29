//
//  ToDOIdeaTableViewCell.swift
//  to-do-list-app-iOS
//
//  Created by Apple on 29/01/2023.
//

import UIKit

class ToDOIdeaTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    var toDOIdea: ToDoModel? = nil {
        didSet {
            self.configureView()
        }
    }
    
    func configureView () {
        self.titleLabel?.text = toDOIdea?.title ?? ""
        self.descriptionLabel?.text = toDOIdea?.description ?? ""
        self.dueDateLabel.text = toDOIdea?.dueDate ?? ""
        addShadow()
    }
    func addShadow(){
        mainView.layer.cornerRadius = 10
        // border
        mainView.layer.borderWidth = 1.0
        mainView.layer.borderColor = UIColor.black.cgColor

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

