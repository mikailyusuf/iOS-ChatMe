//
//  ChatViewController.swift
//  Chatme
//
//  Created by Mikail on 08/01/2022.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messagetextField: UITextField!
    
    let db = Firestore.firestore()
    
    var messages:[Message] = [
        Message(sender: "devmk@yahoo.com", body: "Hi"),
        Message(sender: "abdul@gmail.com", body: "How You"),
        Message(sender: "devmk@yahoo.com", body: "Great"),
        Message(sender: "abdul@gmail.com", body: "Fine")
    
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        title = Constants.appName
        navigationItem.hidesBackButton = true
        loadMessages()
        // Do any additional setup after loading the view.
    }
    
    func loadMessages(){
        
        db.collection(Constants.FireStore.ColectionName).order(by: Constants.FireStore.date).addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
                if let error = error {
                    print("Error retreiving collection: \(error)")
                }else{
                    if let documentSnapShot = querySnapshot?.documents{
                        
                        for doc in documentSnapShot{
                            let data = doc.data()
                            if let sender = data[Constants.FireStore.sender] as? String, let body = data[Constants.FireStore.body] as? String{
                                
                                let message = Message(sender: sender, body: body)
                                self.messages.append(message)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                            
                        }
                    }
                }
            }
    }
    

    @IBAction func actionSendMessage(_ sender: Any) {
        
        if  let message = messagetextField.text ,let user = Auth.auth().currentUser?.email{
            // Add a new document with a generated ID
    
            db.collection(Constants.FireStore.ColectionName).addDocument(data: [
                Constants.FireStore.sender: user,
                Constants.FireStore.body: message,
                Constants.FireStore.date: Date().timeIntervalSince1970
            ])
            { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    self.messagetextField.text = ""
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

    @IBAction func actionLogOut(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
      
    }
    
}

extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        cell.mesaageBody.text = messages[indexPath.row].body
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
}

