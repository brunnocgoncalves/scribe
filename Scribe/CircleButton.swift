//
//  CircleButton.swift
//  Scribe
//
//  Created by Brunno Goncalves on 17/11/16.
//  Copyright © 2016 brunnogoncalves. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0{
        
        didSet{
            
            setUpView()
            
        }
        
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    func setUpView(){
        
        layer.cornerRadius = cornerRadius
        
    }
   
}
