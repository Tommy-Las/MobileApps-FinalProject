//
//  ListCell.swift
//  Shoppy-Falcone
//
//  Created by Fallon Falcone on 11/17/22.
//

import UIKit

class ListCell: UITableViewCell {
    
    // December 4 code, Oliver's transplant
    
    var cellObjectId = "" //A cell specific variable that isn't used for a cell's UI.
    
    @IBAction func ViewList(_ sender: Any) { //This outlet is connected to the button "View List" that is used to view the items of a specific cell.
        
        globalObjectId = cellObjectId //assign the cell's callObjectId to the global variable that stores a list's objectId as a String.
        
    }
    
    // December 4 code end
    
    @IBOutlet weak var listTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
