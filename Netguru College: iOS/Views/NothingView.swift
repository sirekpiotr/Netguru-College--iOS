//
//  NothingView.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 04/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import UIKit

class NothingView: UIView {
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 25))
        headerLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerLabel.textColor = .black
        headerLabel.textAlignment = .center
        headerLabel.text = "Oh no!"
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        return headerLabel
    }()
    
    private lazy var subheaderLabel: UILabel = {
        let subheaderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        subheaderLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        subheaderLabel.numberOfLines = 0
        subheaderLabel.textColor = .gray
        subheaderLabel.textAlignment = .center
        subheaderLabel.text = "You don't have any tasks right now."
        
        subheaderLabel.translatesAutoresizingMaskIntoConstraints = false
        return subheaderLabel
    }()
    
    lazy var addTaskButton: PrimaryActionButton = {
        let addTaskButton = PrimaryActionButton()
        addTaskButton.setTitle("Add first task".uppercased(), for: .normal)
        return addTaskButton
    }()
    
    private func prepareLayout() {
        addSubview(headerLabel)
        addSubview(subheaderLabel)
        addSubview(addTaskButton)
        
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -25),
            headerLabel.heightAnchor.constraint(equalToConstant: 25),
            headerLabel.widthAnchor.constraint(equalToConstant: 300),
            
            subheaderLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            subheaderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subheaderLabel.heightAnchor.constraint(equalToConstant: 40),
            subheaderLabel.widthAnchor.constraint(equalToConstant: 200),
            
            addTaskButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            addTaskButton.heightAnchor.constraint(equalToConstant: 50),
            addTaskButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
