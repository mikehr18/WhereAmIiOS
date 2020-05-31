//
//  TableCellTableViewCell.swift
//  WhereAmI
//
//  Created by Aldo Corona on 29/05/20.
//  Copyright © 2020 IMOX. All rights reserved.
//

import UIKit

class TableCellTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idDeviceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
