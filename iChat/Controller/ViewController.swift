//
//  ViewController.swift
//  iChat
//
//  Created by Andres Marquez on 2022-08-10.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkAuthentification()
    }
    
    func checkAuthentification() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let viewController = LogInViewController()
            let navigation = UINavigationController(rootViewController: viewController)
            navigation.modalPresentationStyle = .fullScreen
            present (navigation, animated: false)
        }
    }
}

