//
//  CreateCircle.swift
//  WorkTime
//
//  Created by Rin on 2020/06/27.
//  Copyright © 2020 竹村凜. All rights reserved.
//

import Foundation
import UIKit

struct CreateCircle {
    
    let button: UIButton
    
    func conversion() {
        
        let halfWidth = self.button.bounds.height / 2
        button.layer.cornerRadius = CGFloat(halfWidth)
        
        
    }
    
    
}
