//
//  signup-textfield.swift
//  timer3
//
//  Created by 吉川椛 on 2019/10/04.
//  Copyright © 2019 吉川椛. All rights reserved.
//

import UIKit

class signup_textfield: UITextField {
    
    //アンダーラインを引くため
    let underline: UIView = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.frame.size.height = 30
        self.frame.size.width = 208
        
        composeUnderline()
        
        //textfieldの周りの線を消す
        self.borderStyle = .none
        
        
        
    }
    
    private func composeUnderline(){
        
        self.underline.frame = CGRect(
            x: 0,                    // x, yの位置指定は親要素,
            y: self.frame.height,    // この場合はCustomTextFieldを基準にする
            width: self.frame.width,
            height: 2.5)
        
        self.underline.backgroundColor = UIColor(red:0.36, green:0.61, blue:0.93, alpha:1.0)
        
        self.addSubview(self.underline)
        self.bringSubviewToFront(self.underline)
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
