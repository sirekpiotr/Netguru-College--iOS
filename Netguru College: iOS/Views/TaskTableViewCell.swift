//
//  TaskTableViewCell.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 04/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    lazy var taskNameLabel: UILabel = {
        let taskNameLabel = UILabel()
        taskNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        taskNameLabel.numberOfLines = 0
        
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskNameLabel
    }()
    
    lazy var taskDescriptionLabel: UILabel = {
        let taskDescriptionLabel = UILabel()
        taskDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        taskDescriptionLabel.numberOfLines = 2
        
        taskDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskDescriptionLabel
    }()
    
    private func prepareLayout() {
        self.backgroundColor = .white
        
        contentView.addSubview(taskNameLabel)
        contentView.addSubview(taskDescriptionLabel)
        
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            taskNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            taskNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            taskDescriptionLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            taskDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            taskDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            taskDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
