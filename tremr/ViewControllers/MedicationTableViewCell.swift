//
//  Name of file: MedicationTableViewCell.swift
//  Programmers: Jason Fevang
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
//          2018-10-20:
// Known Bugs:

import UIKit

class MedicationTableViewCell: UITableViewCell {
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
