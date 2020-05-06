//
//  CatalogTableViewCell.swift
//  iTunes Catalog
//
//  Created by KIRILL CHUMAK on 5/4/20.
//  Copyright © 2020 Kirill Chumak. All rights reserved.
//

import UIKit

class CatalogTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var url: UILabel!
    @IBOutlet var genre: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
