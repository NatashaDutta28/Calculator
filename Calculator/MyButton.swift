//
//  MyButton.swift
//  Calculator
//
//  Created by Natasha Dutta on 22/09/15.
//  Copyright © 2015 Natasha Dutta. All rights reserved.
//

import UIKit

class MyButton: UIButton {

    
    override func awakeFromNib() {
        self.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.layer.borderWidth = 0.5
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
