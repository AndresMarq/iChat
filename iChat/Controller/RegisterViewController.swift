//
//  RegisterViewController.swift
//  iChat
//
//  Created by Andres Marquez on 2022-08-13.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    private let userImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "person.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(tappedChangePic), for: .touchUpInside)
        return button
    }()

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
        
        // Add empty person button on top of view
        let size = view.width / 3
        userImageButton.frame = CGRect(
            x: (view.width - size) / 2,
            y: 100,
            width: size,
            height: size
        )
        userImageButton.layer.cornerRadius = userImageButton.width / 2
        view.addSubview(userImageButton)
        
        // Add first and last name
        firstNameTextField.frame = CGRect(
            x: view.width * 0.1,
            y: userImageButton.bottom + 30,
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
                !firstName.isEmpty,
              !lastName.isEmpty,
                !email.isEmpty,
                !password.isEmpty else {
            self.view.endEditing(true)
            logInError()
            return
        }
        
        // Firebase create user
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            guard let authResult = result, error == nil else {
                // handle
                return
            }
            
            // Do something with result
        })
    }
    
    private func logInError() {
        let ac = UIAlertController(title: "Error", message: "All fields are required to register", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    @objc private func tappedChangePic() {
        showPictureActionSheet()
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

// Get results from user taking picture or selecting photo from library
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showPictureActionSheet() {
        let sheet = UIAlertController(title: "Select Profile Picture", message: "Preferred method", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            self?.useCamera()
        }))
        sheet.addAction(UIAlertAction(title: "Library", style: .default, handler: { [weak self] _ in
            self?.useLibrary()
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(sheet, animated: true)
    }
    
    func useCamera() {
        let controller = UIImagePickerController()
        controller.sourceType = .camera
        controller.delegate = self
        controller.allowsEditing = true
        present(controller, animated: true)
    }
    
    func useLibrary() {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        controller.allowsEditing = true
        present(controller, animated: true)
    }
    
    // Called when user takes or select photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.userImageButton.setImage(image, for: .normal)
    }
    
    // Called when cancel taking picture or photo selection
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
