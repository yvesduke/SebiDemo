//
//  HerbsView.swift
//  DrSebi
//
//  Created by Yves Dukuze on 18/10/2023.
//

import UIKit

final class HerbsView: UIView {
    
    let tableView: UITableView = {
       let table = UITableView()
       table.register(UITableViewCell.self, forCellReuseIdentifier: "HerbCell")
       table.translatesAutoresizingMaskIntoConstraints = false
       return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}



