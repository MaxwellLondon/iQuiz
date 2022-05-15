//
//  QuizViewCell.swift
//  iQuiz
//
//  Created by Maxwell London on 5/12/22.
//

import UIKit

class QuizViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet var quizTextLabel: UILabel!
    
    @IBOutlet var quizContentView: UIView!
}
