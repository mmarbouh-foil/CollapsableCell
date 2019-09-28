//
//  ViewController.swift
//  CollapsableCell
//
//  Created by Mohamed Marbouh on 2019-09-27.
//  Copyright © 2019 Mohamed Marbouh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    private var expandedIndices: [Int] = []
    private let cellReuse = "card"
    private let collapsedCellHeight: CGFloat = 180
    private let expandedCellHeight: CGFloat = 470
    
    private lazy var defaultCard: Card = {
        return Card(position: 0,
                    price: 25,
                    requests: 2,
                    pledge: 150,
                    weight: "light",
                    sender: "Mohamed Marbouh",
                    profileImage: "Profile",
                    origin: "Avenza Systems",
                    destination: "Foil Music App",
                    delivery: Date(),
                    deadline: Date(timeIntervalSinceNow: 600),
                    amountOfRequests: 1)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = UIImageView()
        background.image = UIImage(named: "Background")
        
        tableView.backgroundView = background
        tableView.dataSource = self
        tableView.delegate = self
        tableView.makeAutoLayout()
        tableView.register(CollapsableTableViewCell.self, forCellReuseIdentifier: cellReuse)
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        
        tableView.constrain()
    }

}

// Data source

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var card = defaultCard
        card.position = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuse, for: indexPath) as! CollapsableTableViewCell
        cell.configure(with: card, expanded: expandedIndices.contains(indexPath.row))
        cell.selectionStyle = .none
        
        return cell
    }
    
}

// Delegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return expandedIndices.contains(indexPath.row) ? expandedCellHeight : collapsedCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CollapsableTableViewCell
        
        if cell.isExpanded() {
            expandedIndices.removeAll(where: {$0 == indexPath.row})
            cell.collapse()
        } else {
            expandedIndices.append(indexPath.row)
            cell.expand()
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}

