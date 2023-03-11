//
//  Extensions.swift
//  quiz
//
//  Created by crow on 10/03/2023.
//

import Foundation
import UIKit
extension UIButton {
    
    func disabledButtonStyle(){
        self.backgroundColor = Farby.cervena
        self.setTitleColor(.black, for: .disabled)
        self.isEnabled = false
    }
    
    func enabledButtonStyle(){
        self.backgroundColor = .clear
        self.setTitleColor(.black, for: .normal)
        self.isEnabled = true
    }
    
}
