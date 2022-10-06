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
    var messages  : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTableView.register(UINib(nibName: "MesssageTableViewCell", bundle:nil), forCellReuseIdentifier: "MesssageTableViewCell")

        self.navigationItem.setHidesBackButton(true, animated: true)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOut))

        
        // Do any additional setup after loading the view.
        loadMessage()
    }
    
    
    
    func loadMessage(){
        
        db.collection(Constant.FirbaseLibrary.collectionName).order(by: Constant.FirbaseLibrary.dateField).addSnapshotListener  { (querySnapshot, error) in
            self.messages = []
            
            
            if let error = error {
                print("Issue in retriving data")
            }
            else{
                if let snapshotDocuments = querySnapshot?.documents{
                    
                    for doc in snapshotDocuments {
                        
                        let data = doc.data()
                        if let messgeSender = data[Constant.FirbaseLibrary.senderField] as? String , let messageBody = data[Constant.FirbaseLibrary.bodyField] as? String{
                            
                         let newMessage = Message(sender: messgeSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            
                            
                            DispatchQueue.main.async {
                                self.messageTableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.messageTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                            
                            
                            
                        }
                    }
                }
            }
        }
        
    }
    
    @objc func logOut(){
        let firebaseAuth = Auth.auth()
       do {
         try firebaseAuth.signOut()
           navigationController?.popToRootViewController(animated: true)
       } catch let signOutError as NSError {
         print("Error signing out: %@", signOutError)
       }
         
        
        
        
        
    }
    
//    func loadMessages() {
//
//        db.collection(K.FStore.collectionName)
//            .order(by: K.FStore.dateField)
//            .addSnapshotListener { (querySnapshot, error) in
//
//            self.messages = []
//
//            if let e = error {
//                print("There was an issue retrieving data from Firestore. \(e)")
//            } else {
//                if let snapshotDocuments = querySnapshot?.documents {
//                    for doc in snapshotDocuments {
//                        let data = doc.data()
//                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
//                            let newMessage = Message(sender: messageSender, body: messageBody)
//                            self.messages.append(newMessage)
//
//                            DispatchQueue.main.async {
//                                   self.tableView.reloadData()
//                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
//                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//
    
    
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

extension MessangerViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = messageTableView.dequeueReusableCell(withIdentifier: "MesssageTableViewCell", for: indexPath) as! MesssageTableViewCell
        
        cell.messageLabel.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.youImageView.isHidden = true
            cell.meImageview.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: Constant.AppColor.appLightPurpleColor)
            cell.messageLabel.textColor = UIColor(named: Constant.AppColor.appPurpleColor)
            
        }
        else{
            
            cell.youImageView.isHidden = false
            cell.meImageview.isHidden = true
            
            cell.messageView.backgroundColor = UIColor(named: Constant.AppColor.appPurpleColor)
            cell.messageLabel.textColor = UIColor(named: Constant.AppColor.appLightPurpleColor)
            
            
        }
        
        
        
        
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
}
