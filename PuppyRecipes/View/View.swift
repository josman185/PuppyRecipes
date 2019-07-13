//
//  ViewModel.swift
//  PuppyRecipes
//
//  Created by jos on 7/8/19.
//  Copyright © 2019 My Organization. All rights reserved.
//

import Foundation
import UIKit

class CustomView: UITextField {
    
    // Text Field ingredientes.
    class func customTextField() -> UITextField {
        let sampleTextField = UITextField(frame: CGRect(x: 20, y: 100, width: 200, height: 50))
        sampleTextField.placeholder = "teclea tu receta"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.borderStyle = UITextBorderStyle.line
        return sampleTextField
    }
    
    // Boton buscar Recetas.
    class func searchButton() -> UIButton {
        let searchBtn = UIButton(frame: CGRect(x: 250, y: 100, width: 150, height: 50))
        searchBtn.setTitle("Buscar", for: .normal)
        searchBtn.setTitleColor(UIColor.white, for: .normal)
        searchBtn.backgroundColor = UIColor.init(red: 54/255, green: 150/255, blue: 27/255, alpha: 1.0)
        searchBtn.layer.cornerRadius = 10
        searchBtn.clipsToBounds = true
        return searchBtn
    }
}
