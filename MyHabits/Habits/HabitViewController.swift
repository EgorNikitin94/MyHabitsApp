//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Егор Никитин on 24.11.2020.
//

import UIKit

final class HabitViewController: UIViewController {
    
    // MARK:- Properties
    
    private lazy var backButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.target = self
        button.tintColor = Colors.purple
        button.title = "Отмена"
        button.style = .done
        button.action = #selector(backHabitButtonTapped)
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
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.toAutoLayout()
        return label
    }()
    
    private lazy var habitTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.textColor = .systemBlue
        textField.toAutoLayout()
        return textField
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.toAutoLayout()
        return label
    }()
    
    private lazy var setColorWell: UIColorWell = {
        let colorWell = UIColorWell(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        colorWell.selectedColor = Colors.orange
        colorWell.accessibilityActivate()
        colorWell.layer.borderWidth = 0
        colorWell.toAutoLayout()
        return colorWell
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.toAutoLayout()
        return label
    }()
    
    private lazy var subsidiaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в "
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.toAutoLayout()
        return label
    }()
    
    private lazy var showTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = Colors.purple
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        label.text = formatter.string(from: timePicker.date)
        label.toAutoLayout()
        return label
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let time = UIDatePicker()
        time.datePickerMode = .time
        time.preferredDatePickerStyle = .wheels
        time.addTarget(self, action: #selector(getFromTimePicker), for: .valueChanged)
        time.toAutoLayout()
        return time
    }()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        setupLayout()
        navigationItem.title = "Cоздать"
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK:- LayoutSettings
    
    private func setupLayout() {
        
        view.addSubview(nameLabel)
        view.addSubview(habitTextField)
        view.addSubview(colorLabel)
        view.addSubview(setColorWell)
        view.addSubview(timeLabel)
        view.addSubview(subsidiaryLabel)
        view.addSubview(showTimeLabel)
        view.addSubview(timePicker)
        
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            habitTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            habitTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            habitTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            colorLabel.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            colorLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            setColorWell.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            setColorWell.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: setColorWell.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            subsidiaryLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            subsidiaryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            showTimeLabel.topAnchor.constraint(equalTo: subsidiaryLabel.topAnchor),
            showTimeLabel.leadingAnchor.constraint(equalTo: subsidiaryLabel.trailingAnchor),
            
            timePicker.topAnchor.constraint(equalTo: subsidiaryLabel.bottomAnchor, constant: 15),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    // MARK:- Actions
    @objc func backHabitButtonTapped() {
        dismiss(animated: true) {
            print("backButton was tapped")
            print("habits view controller presented successfully")
        }
    }
    
    @objc func saveHabitButtonTaped() {
        guard let habitText = habitTextField.text else {return}
        guard let color = setColorWell.selectedColor else {return}
        
        let newHabit = Habit(name: habitText,
                             date: timePicker.date,
                             color: color)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        
        dismiss(animated: true){
            print("safeButton was tapped")
            print("habits view controller presented successfully")
            
        }
    }
    
    @objc func getFromTimePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        showTimeLabel.text = formatter.string(from: timePicker.date)
    }
    
    
}

