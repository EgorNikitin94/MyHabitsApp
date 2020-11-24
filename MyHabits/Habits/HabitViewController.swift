//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Егор Никитин on 24.11.2020.
//

import UIKit

class HabitViewController: UIViewController {
    
    private lazy var backButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.target = self
        button.tintColor = Colors.purple
        button.title = "Отмена"
        button.style = .done
        button.action = #selector(backHabitButtonTaped)
        return button
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.target = self
        button.tintColor = Colors.purple
        button.title = "Сохранить"
        button.style = .plain
        button.action = #selector(saveHabitButtonTaped)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cоздать"
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = backButton
    }
    
    
    // MARK: Actions
    @objc func backHabitButtonTaped() {
        dismiss(animated: true){
            print("backButton was taped")
            print("habits view controller presented succesfully")
        }
    }
    
    @objc func saveHabitButtonTaped() {
        
    }
    
    
}
