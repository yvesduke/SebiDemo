//
//  SecondController.swift
//  DrSebi
//
//  Created by Yves Dukuze on 18/10/2023.
//
import UIKit
import RxSwift
import RxCocoa

class HerbsViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let herbsViewModel = HerbsViewModel()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "HerbCell")
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 60
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Healing Herbs"
        
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        herbsViewModel.herbs
            .bind(to: tableView.rx.items) { (tableView, row, herbItem) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "HerbCell", for: IndexPath(row: row, section: 0))
                if cell.detailTextLabel == nil {
                    let newCell = UITableViewCell(style: .subtitle, reuseIdentifier: "HerbCell")
                    newCell.textLabel?.text = herbItem.name
                    newCell.detailTextLabel?.text = herbItem.benefits
                    return newCell
                }
                cell.textLabel?.text = herbItem.name
                cell.detailTextLabel?.text = herbItem.benefits
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension HerbsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
    }
}
