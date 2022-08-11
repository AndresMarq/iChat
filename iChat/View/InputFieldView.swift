//
//  InputFieldView.swift
//  iChat
//
//  Created by Andres Marquez on 2022-08-10.
//

import UIKit

class InputFieldView: UITextField {

    private let inputField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        return field
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        inputField.frame = frame
        addSubview(inputField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addPlaceholder(placeholder: String) {
        inputField.placeholder = placeholder
    }
}
