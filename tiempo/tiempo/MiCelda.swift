//
//  MiCelda.swift
//  tiempo
//
//  Created by Antonio on 1/14/16.
//  Copyright © 2016 Antonio. All rights reserved.
//

import UIKit

class MiCelda: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var subtitulo: UILabel!
    @IBOutlet weak var subtitulo2: UILabel!
    @IBOutlet weak var subtitulo3: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var ciudad: UILabel!
    @IBOutlet weak var estado: UILabel!
    @IBOutlet weak var fecha: UILabel!
}
