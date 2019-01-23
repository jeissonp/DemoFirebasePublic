//
//  TableViewController.swift
//  DemoFirebase
//
//  Created by jeisson on 11/25/18.
//  Copyright © 2018 jeisson. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView

class TableViewController: UITableViewController {
    
    let ref = Database.database().reference(withPath: "messages")
    var items: [ItemModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userID = Auth.auth().currentUser?.uid

        ref.child(userID!).observe(.value, with: { snapshot in
            var newItems: [ItemModel] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let item = ItemModel(snapshot: snapshot) {
                    print(item.text)
                    newItems.append(item)
                }
            }
            
            self.items = newItems
            self.tableView.reloadData()
        })
        
        //ref = Database.database().reference(withPath: 'Messages)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].text
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = SCLAlertView()
            alert.addButton("Delete") {
                let item = self.items[indexPath.row]
                item.ref?.removeValue()
            }
            alert.showSuccess("Confirm", subTitle: "Delete item?")
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func actionAddOnClick(_ sender: Any) {
        let alert = SCLAlertView()
        
        let txt = alert.addTextField("Enter your text")
        alert.addButton("Add") {
            let userID = Auth.auth().currentUser?.uid
            
            self.ref.child(userID!).childByAutoId().setValue(["text": txt.text])
        }
        alert.showEdit("Add", subTitle: "Add new task")
    }
    
    @IBAction func actionCloseOnClick(_ sender: Any) {
        let alert = SCLAlertView()
        alert.addButton("Logout") {
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
            } catch (let error) {
                print("Auth sign out failed: \(error)")
            }
        }
        alert.showNotice("Confirm", subTitle: "Logout?")
    }
    
}
