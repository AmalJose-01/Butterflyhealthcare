//
//  Commoncornerradius_Swift.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 1/1/2024.

import Foundation
import UIKit

public class Commoncornerradius_Swift: NSObject {
    
      let borderShadowColor = UIColor(red: 231.0, green: 231.0, blue: 231.0, alpha: 1.00)
    let borderGrayColor = UIColor.lightGray
    

    public func setCornerRadiusAndBorderForObject_WithShadow_Swift(_ object: Any? , Radius: CGFloat) {
        
        if object is UIView {
            let viewObject = object as? UIView
            viewObject?.layer.borderColor = UIColor.gray.cgColor
            viewObject?.layer.borderWidth = 1
            viewObject?.layer.cornerRadius = Radius
            
            viewObject?.layer.masksToBounds = true

            viewObject?.layer.shadowColor = borderShadowColor.cgColor
            viewObject?.layer.shadowOffset = CGSize(width: 3, height: 3)
            viewObject?.layer.shadowOpacity = 0.8
            viewObject?.layer.shadowRadius = 4.0
         
        }else if object is UIButton {
            let viewObject = object as? UIButton
            
            viewObject?.layer.borderColor = UIColor.gray.cgColor
            viewObject?.layer.borderWidth = 1
            viewObject?.layer.cornerRadius = Radius
            
            viewObject?.layer.masksToBounds = true

            
            viewObject?.layer.shadowColor = borderShadowColor.cgColor
            viewObject?.layer.shadowOffset = CGSize(width: 3, height: 3)
            viewObject?.layer.shadowOpacity = 0.8
            viewObject?.layer.shadowRadius = 4.0
          
        }
    }
    
    
}


