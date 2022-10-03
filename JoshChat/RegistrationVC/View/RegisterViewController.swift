//
//  RegisterViewController.swift
//  JoshChat
//
//  Created by Josh on 03/10/22.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func registationButtonClicked(_ sender: Any) {
        
        if let username = usernameTextField.text , let password = passwordTextField.text{
            
            Auth.auth().createUser(withEmail: username, password: password) { authDataResult, error in
                if error == nil{
                    
                    self.performSegue(withIdentifier: Constant.registerSegue, sender: self)
                    
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
