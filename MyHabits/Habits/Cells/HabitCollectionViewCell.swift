//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Егор Никитин on 26.11.2020.
//

import UIKit

final class HabitCollectionViewCell: UICollectionViewCell {
    
    // MARK:- Properties
    
    static var reuseID: String {
        return String(describing: HabitCollectionViewCell.self)
    }
    
    var isOnRoundButton: (() -> Void)?
    
    var habit: Habit? {
        didSet {
            nameOfHabitLabel.text = habit?.name
            nameOfHabitLabel.textColor = habit?.color
            everyDayLabel.text = habit?.dateString
            successivelyLabel.text = "Подряд:" + String(habit?.trackDates.count ?? 0)
            roundButton.layer.borderColor = habit?.color.cgColor
            drawRoundButton()
        }
    }
    
    private lazy var nameOfHabitLabel: UILabel = {
        let label = UILabel()
        label.text = "Всё получится!"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 2
        label.toAutoLayout()
        return label
    }()
    
    private lazy var everyDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = Colors.sGray2
        label.toAutoLayout()
        return label
    }()
    
    private lazy var successivelyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = Colors.sGray2
        label.toAutoLayout()
        return label
    }()
    
    private lazy var roundButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(roundButtonTap), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    
    // MARK:- LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        roundButton.layer.cornerRadius = roundButton.frame.height / 2
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:- LayoutSettings
    
    private func setupLayout() {
        
        contentView.addSubview(nameOfHabitLabel)
        contentView.addSubview(everyDayLabel)
        contentView.addSubview(successivelyLabel)
        contentView.addSubview(roundButton)
        
        let constraints = [
            
            nameOfHabitLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameOfHabitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameOfHabitLabel.widthAnchor.constraint(equalToConstant: (contentView.frame.width / 2) + 20),
            
            everyDayLabel.topAnchor.constraint(equalTo: nameOfHabitLabel.bottomAnchor, constant: 4),
            everyDayLabel.leadingAnchor.constraint(equalTo: nameOfHabitLabel.leadingAnchor),
            
            successivelyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            successivelyLabel.leadingAnchor.constraint(equalTo: nameOfHabitLabel.leadingAnchor),
            
            roundButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 47),
            roundButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            roundButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -47),
            roundButton.widthAnchor.constraint(equalToConstant: 36),
            roundButton.heightAnchor.constraint(equalToConstant: 36)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    // MARK:- Actions
    
    @objc private func roundButtonTap() {
        
        guard habit?.isAlreadyTakenToday == false else {
            print("AlreadyTaken")
            return
        }
        roundButton.backgroundColor = habit?.color
        roundButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        roundButton.tintColor = .white
        HabitsStore.shared.track(habit!)
        isOnRoundButton?()
    }
    
    func drawRoundButton() {
        
        if habit?.isAlreadyTakenToday == true && roundButton.layer.borderColor == habit?.color.cgColor {
            roundButton.backgroundColor = habit?.color
            roundButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            roundButton.tintColor = .white
        } else {
            roundButton.backgroundColor = .white
        }
    }
    
    
    
}
