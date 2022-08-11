//
//  Extensions.swift
//  iChat
//
//  Created by Andres Marquez on 2022-08-10.
//

import Foundation
import UIKit

extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
    
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
}
