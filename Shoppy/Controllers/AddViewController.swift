//
//  AddViewController.swift
//  Shoppy
//
//  Created by Alexandro Galvez-Vega on 11/22/22.
//

import UIKit
import Parse

class AddViewController: UIViewController {
    
    
    
    
    
    
    @IBOutlet weak var textField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Of no consequence for this view controller
    }
    

    
    @IBAction func onSubmitButton(_ sender: Any) {
        
        let listitem = PFObject(className: "ListItem")
        
        listitem["name"] = textField.text
        
        listitem.saveInBackground { (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else {
                print("error!")
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
