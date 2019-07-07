//
//  ViewExtensions.swift
//  Netguru College: iOS
//
//  Created by Piotr Sirek on 06/07/2019.
//  Copyright © 2019 Piotr Sirek. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func adjustScrollViewSize(with scrollView: UIScrollView) {
        DispatchQueue.main.async {
            var contentRect = CGRect.zero
            
            for view in scrollView.subviews {
                contentRect = contentRect.union(view.frame)
            }
            
            scrollView.contentSize = CGSize(width: contentRect.width, height: contentRect.height + 50)
        }
    }
}
