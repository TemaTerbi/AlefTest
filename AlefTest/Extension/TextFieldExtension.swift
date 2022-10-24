//
//  TextFieldExtension.swift
//  AlefTest
//
//  Created by Артем Соловьев on 24.10.2022.
//

import UIKit

//Расширение для всех текстоввых полей, чтобы можно было ставить padding с любой стороны
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
