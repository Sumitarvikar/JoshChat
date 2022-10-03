//
//  LoginViewController.swift
//  JoshChat
//
//  Created by Josh on 03/10/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextFIeld: UITextField!
    @IBOutlet weak var passwordTextFIeld: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func LoginButtonClicked(_ sender: Any) {
        
        if let userName = userNameTextFIeld.text , let password = passwordTextFIeld.text {
            
            Auth.auth().signIn(withEmail: userName, password: password) { authDataREsult, error in
                if error != nil {
                    print(error)
                }
                else{
                    self.performSegue(withIdentifier: Constant.loginSegue, sender: self)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
