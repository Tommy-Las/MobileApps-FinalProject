//
//  AddListViewController.swift
//  ListApp
//
//  Created by Tommy on 11/15/22.
//

import UIKit

class AddListViewController: UIViewController {

    
    @IBOutlet weak var createListButton: UIButton!
    @IBOutlet weak var newListName: UITextField!
    @IBOutlet weak var goBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createList(_ sender: Any) {
        print("testing")
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
