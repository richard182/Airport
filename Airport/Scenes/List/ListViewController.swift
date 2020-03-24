//
//  ListViewController.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(cellType: AirportTableViewCell.self)
        }
    }
    
    var airports: [Airport] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Airports"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AirportTableViewCell.self, for: indexPath)
        cell.configuration(airport: airports[indexPath.row])
        return cell
    }
}
