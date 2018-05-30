//
//  ViewController.swift
//  Hi-Touch
//
//  Created by Swathi B on 09/03/18.
//  Copyright © 2018 Swathi B. All rights reserved.
//

import UIKit
import MaterialComponents.MDCTextField
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: MDCTextField!
    @IBOutlet weak var passwordTextField: MDCTextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = "dinesh.kumar@informa.com"
        passwordTextField.text = "P@ss1234"
        signin.isUserInteractionEnabled = true

    
    }
    
    @IBAction func login(_ sender: Any) {
        activityIndicator.startAnimating()
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            ]
        
        let parameters: Parameters = [
            "username": emailTextField.text as Any,
            "password": passwordTextField.text as Any
        ]
        
        Alamofire.request(loginURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            self.activityIndicator.stopAnimating()
            switch(response.result) {
            case .success(_):
                self.performSegue(withIdentifier: "Login segue", sender: self)
                if let data = response.result.value as? [String: Any], let id_token = data["id_token"] as? String {
                    let token = "idtoken " + id_token
                    UserDefaults.standard.set(token, forKey: userToken)
                    print(response.result.value)
                }
                break
                
            case .failure(_):
                print(response.result.error)
                break
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let emailTextField = emailTextField.text, let passwordTextField = passwordTextField.text,emailTextField.count > 0, passwordTextField.count > 0 {
            signin.isUserInteractionEnabled = true
        }
    }
}

