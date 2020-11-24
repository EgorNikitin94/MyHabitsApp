//
//  SplashScreenViewController.swift
//  MyHabits
//
//  Created by Егор Никитин on 23.11.2020.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    private lazy var iconView: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "main_icon")
        
        icon.toAutoLayout()
        return icon
    }()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.text = "MyHabits"
        name.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        name.textColor = Colors.darkPurple
        name.toAutoLayout()
        return name
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }
    
    
    private func setupLayout() {
        view.addSubview(iconView)
        view.addSubview(nameLabel)
        
        let constraints = [
            iconView.widthAnchor.constraint(equalToConstant: 120),
            iconView.heightAnchor.constraint(equalToConstant: 120),
            iconView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            nameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
