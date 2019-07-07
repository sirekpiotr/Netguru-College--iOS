//
//  TaskNameView.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 05/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import UIKit

class TaskNameView: UIView {
    let randomPlaceholderForNameTextField = ["Walk with dog", "Wash dishes", "Join to Netguru iOS developers team", "Repair car", "Go swimming"]
    
    lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.borderStyle = .none
        nameTextField.placeholder = "E.g. " + randomPlaceholderForNameTextField.randomElement()!
        nameTextField.font = UIFont.preferredFont(forTextStyle: .headline)
        nameTextField.tintColor = UIColor(named: "primaryColor")
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nameTextField
    }()
    
    private func prepareLayout() {
        backgroundColor = .white
        
        addSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            nameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameTextField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
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
