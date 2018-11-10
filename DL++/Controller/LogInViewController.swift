//
//  LogInViewController.swift
//  SHUB
//
//  Created by Nikita Galaganov on 2/7/18.
//  Copyright © 2018 Nikita Galaganov. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class LogInViewController: UIViewController {
    
    @IBOutlet weak var logInButton: TransitionButton!
    @IBOutlet weak var pastelView: PastelView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func buttonAction(_ button: TransitionButton) {
        button.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background

        let URL = "https://dlhackday.herokuapp.com/login"
        let parameters: Parameters = ["id": usernameField.text!, "password": passwordField.text!]

        Alamofire.request(URL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            if response.response?.statusCode == 200 {
                button.stopAnimation(animationStyle: .expand, completion: {
                    UserDefaults.standard.set(true, forKey: "isAuthorized")
                    self.performSegue(withIdentifier: "goToMainMenu", sender: self)
                })
            }
            else if response.response?.statusCode == 401 {

                let message = "Authorization failed"

                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)

                let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)

                alert.addAction(action)
                button.stopAnimation(animationStyle: .normal, completion: nil)
                self.present(alert, animated: true, completion: nil)

            }
        }

    }
    
    @IBAction func signIn(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToSendMessage", sender: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.tintColor = UIColor.white
        passwordField.tintColor = UIColor.white
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        pastelView.animationDuration = 4.0

        pastelView.setColors([#colorLiteral(red: 0.61176470588, green: 0.15294117647, blue: 0.69019607843, alpha: 1), #colorLiteral(red: 1, green: 0.25098039215, blue: 0.50588235294, alpha: 1), #colorLiteral(red: 0.48235294117, green: 0.12156862745, blue: 0.63529411764, alpha: 1), #colorLiteral(red: 0.12549019607, green: 0.29803921568, blue: 1, alpha: 1), #colorLiteral(red: 0.12549019607, green: 0.61960784313, blue: 1, alpha: 1), #colorLiteral(red: 0.35294117647, green: 0.47058823529, blue: 0.49803921568, alpha: 1), #colorLiteral(red: 0.22745098039, green: 1, blue: 0.85098039215, alpha: 1)])
        
        pastelView.startAnimation()
        
        setNeedsStatusBarAppearanceUpdate()
        
        logInButton.layer.cornerRadius = 8
        logInButton.layer.borderColor = UIColor.white.cgColor
        logInButton.layer.borderWidth = 1
        
        usernameField.backgroundColor = UIColor(white: 1, alpha: 0.2)
        passwordField.backgroundColor = UIColor(white: 1, alpha: 0.2)
        usernameField.layer.cornerRadius = 8
        passwordField.layer.cornerRadius = 8
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func hideKeyBoard(sender: UITapGestureRecognizer? = nil){
        view.endEditing(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


