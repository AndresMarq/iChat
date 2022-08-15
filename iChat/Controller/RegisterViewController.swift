//
//  RegisterViewController.swift
//  iChat
//
//  Created by Andres Marquez on 2022-08-13.
//

import UIKit

class RegisterViewController: UIViewController {

    private let firstNameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "First Name"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        return field
    }()
    
    private let lastNameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Last Name"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        return field
    }()
    
    private let emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        return field
    }()

    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 15
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account"
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
        
        // Add first and last name
        firstNameTextField.frame = CGRect(
            x: view.width * 0.1,
            y: imageView.bottom + 100,
            width: view.width * 0.8,
            height: 50
        )
        firstNameTextField.delegate = self
        view.addSubview(firstNameTextField)
        
        lastNameTextField.frame = CGRect(
            x: view.width * 0.1,
            y: firstNameTextField.bottom + 20,
            width: view.width * 0.8,
            height: 50
        )
        lastNameTextField.delegate = self
        view.addSubview(lastNameTextField)
        
        // Add e-mail text field
        emailTextField.frame = CGRect(
            x: view.width * 0.1,
            y: lastNameTextField.bottom + 20,
            width: view.width * 0.8,
            height: 50
        )
        emailTextField.delegate = self
        view.addSubview(emailTextField)
        
        // Add password text field
        passwordTextField.frame = CGRect(
            x: view.width * 0.1,
            y: emailTextField.bottom + 20,
            width: view.width * 0.8,
            height: 50
        )
        passwordTextField.delegate = self
        view.addSubview(passwordTextField)
        
        // Add Log In Button
        registerButton.frame = CGRect(
            x: (view.width / 2) - (view.width * 0.125),
            y: passwordTextField.bottom + 20,
            width: view.width * 0.25,
            height: 50
        )
        view.addSubview(registerButton)
    }
    
    @objc private func registerButtonTapped() {
        // Ensures valid e-mail and password fields
        guard let firstName = firstNameTextField.text,
                let lastName = lastNameTextField.text,
                let email = emailTextField.text,
                let password = passwordTextField.text,
                !email.isEmpty,
                !password.isEmpty else {
            self.view.endEditing(true)
            logInError()
            return
        }
        
        // Firebase log in
    }
    
    private func logInError() {
        let ac = UIAlertController(title: "Error", message: "All fields are required to register", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    @objc private func tappedChangePic() {
        
    }
}

// Ensure textfields return and continue properly
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            registerButtonTapped()
        }
        return true
    }
}
