//
//  ChatTxtTblCell.swift
//  SimpleTblViewChat
//
//  Created by Mohit Singh on 20/02/21.
//

import UIKit

class ChatTxtTblCell: UITableViewCell {

    @IBOutlet weak var lblTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
