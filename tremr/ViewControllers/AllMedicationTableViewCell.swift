//
//  Name of file: AllMedicationTableViewCell.swift
//  Programmers: Jason Fevang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-24: Created file and basic functionality
//          2018-11-15: UI Updates
// Known Bugs: N/A

import UIKit

//Class for the table view for all medications 
class AllMedicationTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var medNameLabel: UILabel!
    @IBOutlet weak var dosageLabel: UILabel!
    @IBOutlet weak var delButton: UIButton!
    
    
    //MARK: UITableViewCell override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: Actions
    
    


}
