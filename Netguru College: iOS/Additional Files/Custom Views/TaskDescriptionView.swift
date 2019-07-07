//
//  AddTaskDescriptionView.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 05/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import UIKit

class TaskDescriptionView: UIView, UITextViewDelegate {
    lazy var descriptionTextView: UITextView = {
        let descriptionTextView = UITextView()
        descriptionTextView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        descriptionTextView.isEditable = true
        descriptionTextView.text = "Add a comment..."
        descriptionTextView.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        descriptionTextView.tintColor = UIColor(named: "primaryColor")
        descriptionTextView.sizeToFit()
        descriptionTextView.isScrollEnabled = true
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        return descriptionTextView
    }()

    func textViewDidBeginEditing(_ textView: UITextView) {
        descriptionTextView.text = ""
        descriptionTextView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text == "" {
            descriptionTextView.text = "Add a comment..."
            descriptionTextView.textColor = .lightGray
        }
    }
    
    private func prepareLayout() {
        backgroundColor = .white
        
        addSubview(descriptionTextView)
        
        descriptionTextView.delegate = self
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 14),
            descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -14),
            descriptionTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150)
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
