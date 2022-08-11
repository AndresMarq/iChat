//
//  LogInViewController.swift
//  iChat
//
//  Created by Andres Marquez on 2022-08-10.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Add iChat Icon on top of view
        let size = view.width / 3
        let imageFrame = CGRect(
            x: view.width / 2 - size,
            y: 30,
            width: size,
            height: size
        )
        let imageView = ImageView(frame: imageFrame)
        view.addSubview(imageView)
        
        // Add e-mail text field
        let emailTextFrame = CGRect(
            x: view.width * 0.05,
            y: imageView.bottom + 20,
            width: view.width * 0.8,
            height: 50
        )
        let emailTextField = InputFieldView(frame: emailTextFrame)
        emailTextField.addPlaceholder(placeholder: "Email")
        view.addSubview(emailTextField)
    }
}
