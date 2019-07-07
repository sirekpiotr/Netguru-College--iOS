//
//  NotificationView.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 05/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import UIKit

class NotificationView: UIView {
    lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.axis = .horizontal
        contentStackView.alignment = .leading
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        return contentStackView
    }()
    
    lazy var alarmIcon: UIImageView = {
        let alarmIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        alarmIcon.contentMode = UIView.ContentMode.scaleAspectFill
        alarmIcon.image = UIImage(named: "clock")
        
        alarmIcon.translatesAutoresizingMaskIntoConstraints = false
        return alarmIcon
    }()
    
    lazy var addNotificationButton: UIButton = {
        let addNotificationButton = UIButton()
        addNotificationButton.setTitle("Set notification", for: .normal)
        addNotificationButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        addNotificationButton.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        addNotificationButton.contentHorizontalAlignment = .left
        
        addNotificationButton.translatesAutoresizingMaskIntoConstraints = false
        return addNotificationButton
    }()
    
    private func setupLayout() {
        contentStackView.addArrangedSubview(alarmIcon)
        contentStackView.addArrangedSubview(addNotificationButton)
        
        addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            alarmIcon.heightAnchor.constraint(equalToConstant: 24),
            alarmIcon.widthAnchor.constraint(equalToConstant: 24),
            alarmIcon.trailingAnchor.constraint(equalTo: addNotificationButton.leadingAnchor, constant: -16),
            
            addNotificationButton.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
