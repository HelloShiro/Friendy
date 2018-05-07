//
//  LoginViewController.swift
//  Friendy
//
//  Created by Gary Chen on 24/4/2018.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var loginViewYConstaint: NSLayoutConstraint!

    var avPlayer: AVPlayer?
    var customTabBarController: CustomTabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avPlayer?.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer?.pause()
    }
    
    func setupInterface() {

        loginButton.setCorner(radius: 10)
        
        if let videoUrl = Bundle.main.url(forResource:"defaultVideo", withExtension: "mp4") {
            avPlayer = AVPlayer(url: videoUrl)
            view.setVideo(avPlayer!)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.displaySimpleAlert(title: "Login Fail", message: error!.localizedDescription)
                return
            }
            
            // Successfully logged in
            self.customTabBarController?.login()
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let registerViewController = RegisterViewController(nibName: AccountConstants.REGISTER_VIEW_CONTROLLER, bundle: nil)
        present(registerViewController, animated: true, completion: nil)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        loginViewYConstaint.animate(100, self.view)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginViewYConstaint.animate(150, self.view)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        loginViewYConstaint.animate(100, self.view)
    }

}

