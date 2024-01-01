//
//  CommonFontClass.swift
//
//  Created by AmalsNewMacMachine on 10/18/23.
//

import Foundation
import UIKit

public class CommonFontClass: NSObject {
    
    public func MulishBoldForButton() -> UIFont {
        if UIDevice.isPadDevice {
            let appFont:UIFont = UIFont(name: "Mulish-Bold", size: 18)!
            return appFont
        }else{
            let appFont:UIFont = UIFont(name: "Mulish-Bold", size: 16)!
            return appFont
        }
    }
    
    public func MulishBoldForProfileName_Small() -> UIFont {
        if UIDevice.isPadDevice {
            let appFont:UIFont = UIFont(name: "Mulish-Bold", size: 18)!
            return appFont
        }else{
            let appFont:UIFont = UIFont(name: "Mulish-Bold", size: 16)!
            return appFont
        }
    }
    
    public func MulishBoldCellText_Small() -> UIFont {
        if UIDevice.isPadDevice {
            let appFont:UIFont = UIFont(name: "Mulish-Bold", size: 16)!
            return appFont
        }else{
            let appFont:UIFont = UIFont(name: "Mulish-Bold", size: 14)!
            return appFont
        }
    }
    
    public func MulishRegularForProfileDate() -> UIFont {
        if UIDevice.isPadDevice {
            let appFont:UIFont = UIFont(name: "Mulish-Regular", size: 16)!
            return appFont
        }else{
            let appFont:UIFont = UIFont(name: "Mulish-Regular", size: 14)!
            return appFont
        }
    }
    
   
    public func MulishItalicForLabel() -> UIFont {
        if UIDevice.isPadDevice {
            let appFont:UIFont = UIFont(name: "Mulish-Italic", size: 14)!
            return appFont
        }else{
            let appFont:UIFont = UIFont(name: "Mulish-Italic", size: 12)!
            return appFont
        }
    }
    
    
}


public extension UIDevice {
    class var isPhoneDevice: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    class var isPadDevice: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    class var isTVDevice: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }
    class var isCarPlayDevice: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
}


