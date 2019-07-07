//
//  PrimaryActionButton.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 04/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import UIKit

class PrimaryActionButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "primaryColor")
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        tintColor = .white
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
