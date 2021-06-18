//
//  GMControl.swift
//  AwesomeDropdown
//
//  Created by Gina Mullins on 6/15/21.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class GMControl: UIControl {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

}

extension Reactive where Base: GMControl {
    var tap: RxCocoa.ControlEvent<Swift.Void> {
        return controlEvent(UIControl.Event.touchUpInside)
    }
}
