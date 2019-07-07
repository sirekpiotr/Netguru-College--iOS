//
//  KeyboardExtensions.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 06/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
