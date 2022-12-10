//
//  AddListViewController.swift
//  Shoppy-Falcone
//
//  Created by Fallon Falcone on 11/17/22.
//

import UIKit
import Parse

class AddListViewController: UIViewController {
    
    @IBOutlet weak var listNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCreate(_ sender: Any) {
        let list = PFObject(className: "Lists")
        
        list["name"] = listNameField.text!
        list["creator"] = PFUser.current()
        list["items"] = []
        list["numberOfItems"] = 0
        
        
        list.saveInBackground { (success,error) in
            if success {
                print("List saved!")
            } else {
                print("Error")
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
