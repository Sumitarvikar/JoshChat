//
//  MessangerViewController.swift
//  JoshChat
//
//  Created by Josh on 03/10/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MessangerViewController: UIViewController {

    @IBOutlet weak var messageTableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        
        if let messagebody = messageTextField.text , let messageSender = Auth.auth().currentUser?.email
        {
            db.collection(Constant.FirbaseLibrary.collectionName).addDocument(data: [
                Constant.FirbaseLibrary.senderField: messageSender , Constant.FirbaseLibrary.bodyField: messagebody , Constant.FirbaseLibrary.dateField: Date().timeIntervalSince1970
        
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    
                    DispatchQueue.main.async {
                         self.messageTextField.text = ""
                    }
                }
            }
            
        }
        
        
        
        
        
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
