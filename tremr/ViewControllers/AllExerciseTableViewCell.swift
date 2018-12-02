//
//  Name of file: AllExerciseTableViewCell.swift
//  Programmers: Nic Klaassen and Devansh Chopra
//  Team Name: Co.DEsign
//  Changes been made:
//          2018-10-22: created file
//          2018-10-29: Initialized basic functions
// Known Bugs: N/A

import UIKit

//Class for the table view for all exercise
class AllExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var exerNameLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var delButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
