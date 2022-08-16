//
//  ViewController.swift
//  iChat
//
//  Created by Andres Marquez on 2022-08-10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let userIsLoggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
        
        if !userIsLoggedIn {
            let viewController = LogInViewController()
            let navigation = UINavigationController(rootViewController: viewController)
            //navigation.modalPresentationStyle = .fullScreen
            present(navigation, animated: true)
        }
    }

}

