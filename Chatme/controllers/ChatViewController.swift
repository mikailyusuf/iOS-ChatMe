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
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionSendMessage(_ sender: Any) {
        
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

