//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Егор Никитин on 24.11.2020.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var addHabit: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button = .init(barButtonSystemItem: .add, target: self, action: #selector(tapAddHabitButton))
        button.style = .plain
        button.target = self
        button.tintColor = Colors.purple
        return button
    }()
    
    
    @objc private func tapAddHabitButton() {
        let habitViewController = UINavigationController(rootViewController: HabitViewController())
        habitViewController.view.backgroundColor = .white
        
        present(habitViewController, animated: true) {
            print("habit view controller presented succesfully")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Сегодня"
        navigationItem.rightBarButtonItem = addHabit
        
    }
    
}
