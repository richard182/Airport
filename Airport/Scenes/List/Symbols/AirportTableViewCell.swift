//
//  AirportTableViewCell.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import UIKit

class AirportTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var airportIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configuration(airport: Airport) {
        nameLabel.text = airport.name
        cityLabel.text = airport.cityName
        codeLabel.text = airport.code
        airportIdLabel.text = airport.airportID
    }
}
