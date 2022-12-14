//
//  ListViewController.swift
//  Shoppy-Falcone
//
//  Created by Fallon Falcone on 11/17/22.
//

import UIKit
import Parse


// December 4 code, Oliver's transplant

//This global variable will store the String version of the currently selected list, which is used to do a query for a specific list.
var globalObjectId = ""
// December 4 code end

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    

    
    @IBAction func onViewList(_ sender: Any) { //There is an action outlet with the same name on ListCell.swift, it handles assigning a selected list's objectId to a global variable.
        
        self.performSegue(withIdentifier: "listInfoSegue", sender: nil) //Move to the Items View Controller
       
    }
    
    var lists = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Hello, \((PFUser.current()?.username)!)"
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationItem.title = "Hello, \((PFUser.current()?.username)!)"
        
        let query = PFQuery(className: "Lists").whereKey("creator", equalTo: PFUser.current()!)
        query.includeKeys(["name", "items"])
        query.limit = 20
        
        query.findObjectsInBackground { (lists,error) in
            if lists != nil {
                self.lists = lists!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
        let list = lists[indexPath.row]
        
        cell.listTitle.text = (list["name"] as! String)
             
        cell.cellObjectId = list.objectId! //Assign the Nth list's objectId to the cell's cellObjectId variable. This lets code in the cell swift file to assign it to a global variable in it (Please see ListCell.swift)
        
        cell.listTitle.isUserInteractionEnabled = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.lists[indexPath.row].deleteInBackground()
            self.lists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ItemsViewController") as? ItemsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        let list = lists[indexPath.row]
        vc?.listName = list["name"] as! String
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        delegate.window?.rootViewController = loginViewController
    }
    
    @IBAction func onAddList(_ sender: Any) {
        performSegue(withIdentifier: "AddListSegue", sender: nil)
    }
    
    
    @IBAction func logoutAccount(_ sender: Any) {
        
        PFUser.logOut()
        
        let main = UIStoryboard(name : "Main", bundle: nil)
        
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        
        delegate.window?.rootViewController = loginViewController
        
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
