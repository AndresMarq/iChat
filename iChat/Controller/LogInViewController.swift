//
//  LogInViewController.swift
//  iChat
//
//  Created by Andres Marquez on 2022-08-10.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
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
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
        return button
    }()
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account yet?"
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(registerTapped(_:)), for: .touchUpInside)
        return button
    }()

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
        emailTextField.frame = CGRect(
            x: view.width * 0.1,
            y: imageView.bottom + 100,
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
        logInButton.frame = CGRect(
            x: (view.width / 2) - (view.width * 0.125),
            y: passwordTextField.bottom + 20,
            width: view.width * 0.25,
            height: 50
        )
        view.addSubview(logInButton)
        
        // Add register label and button
        registerLabel.frame = CGRect(
            x: view.width * 0.1,
            y: logInButton.bottom + 20,
            width: view.width * 0.45,
            height: 30
        )
        view.addSubview(registerLabel)
        
        registerButton.frame = CGRect(
            x: registerLabel.right,
            y: logInButton.bottom + 20,
            width: view.width * 0.2,
            height: 30
        )
        view.addSubview(registerButton)
    }
    
    @objc private func logInTapped() {
        // Ensures valid e-mail and password fields
        guard let email = emailTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty else {
            self.view.endEditing(true)
            logInError()
            return
        }
        
        // Firebase log in
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
            guard let authResult = result, error == nil else {
                // Handle
                return
            }
        })
    }
    
    private func logInError() {
        let ac = UIAlertController(title: "Error", message: "Invalid Email or Password", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    @objc private func registerTapped(_ sender: UIButton) {
        let viewController = RegisterViewController()
        navigationController?.pushViewController(viewController, animated: false)
    }
}

// Ensure textfields return and continue properly
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            logInTapped()
        }
        return true
    }
}
