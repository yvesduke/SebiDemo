//
//  HomeController.swift
//  DrSebi
//
//  Created by Yves Dukuze on 18/10/2023.
//
import UIKit

class HomeViewController: UIViewController {
    
    lazy var homeView: HomeView = {
        let homeView = HomeView()
        homeView.translatesAutoresizingMaskIntoConstraints = false
        return homeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        homeView.welcomeTitleLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateMainTitleIn()
        animateMoreDetailsLabelIn()
        animateDescriptionWithSpring()
        
        self.homeView.subTitleLabel.frame.origin.y -= 45
    }
    

    
    private func setupViews() {
        
        view.addSubviews(homeView)
        
    }
    
    private func setupConstraints() {
        
        let safeGuide = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])
    }
    
    private func animateMainTitleIn() {
        UIView.animate(withDuration: 1.8) {
            self.homeView.welcomeTitleLabel.alpha = 1
            self.homeView.welcomeTitleLabel.frame.origin.y -= 54
        }
    }
    
    private func animateMoreDetailsLabelIn() {
        
        UIView.animate(withDuration: 1.8, delay: 0.75, options: [.curveLinear], animations: {
            self.homeView.moreDetailsLabel.alpha = 1
            self.homeView.moreDetailsLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { completed in
            
        }
    }
    
    private func animateDescriptionWithSpring() {
        UIView.animate(withDuration: 2.0, delay: 0.150, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: [], animations: {
            self.homeView.subTitleLabel.alpha = 1
            self.homeView.subTitleLabel.frame.origin.y += 45
        }, completion: nil)
        
    }
    
    private func transitionMainTitle() {
        UIView.transition(with: self.homeView.welcomeTitleLabel, duration: 1.0, options: [], animations: {
            self.homeView.welcomeTitleLabel.isHidden = false
        }, completion: nil)
    }
}
