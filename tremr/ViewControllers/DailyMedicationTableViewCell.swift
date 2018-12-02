//
//  Name of file: MedicationTableViewCell.swift
//  Programmers: Jason Fevang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20: Created file and basic functionality
//          2018-10-20: UI Updates 
// Known Bugs: N/A

import UIKit

//Class for the daily view for the Medication page 
class DailyMedicationTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var medNameLabel: UILabel!
    @IBOutlet weak var medDosageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
