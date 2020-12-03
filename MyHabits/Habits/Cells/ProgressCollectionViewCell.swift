//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Егор Никитин on 26.11.2020.
//

import UIKit

final class ProgressCollectionViewCell: UICollectionViewCell {
    
    // MARK:- Properties
    
    static var reuseID: String {
        return String(describing: ProgressCollectionViewCell.self)
    }
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Всё получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = Colors.sGray
        label.toAutoLayout()
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = String(Int(progressLine.progress * 100)) + "%"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = Colors.sGray
        label.textAlignment = .right
        label.toAutoLayout()
        return label
    }()
    
    private lazy var progressLine: UIProgressView = {
        let progress = UIProgressView()
        progress.tintColor = Colors.purple
        progress.setProgress(HabitsStore.shared.todayProgress, animated: true)
        progress.layer.cornerRadius = 4
        progress.toAutoLayout()
        return progress
    }()
    
    
    // MARK:- LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:- LayoutSettings
    
    
    private func setupLayout() {
        
        contentView.addSubview(messageLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressLine)
        
        let constraints = [
            
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            progressLabel.topAnchor.constraint(equalTo: messageLabel.topAnchor),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            progressLine.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            progressLine.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor),
            progressLine.trailingAnchor.constraint(equalTo: progressLabel.trailingAnchor),
            progressLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            progressLine.heightAnchor.constraint(equalToConstant: 7)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    
    // MARK:- Actions
    
    internal func updateProgressData() {
        progressLine.setProgress(HabitsStore.shared.todayProgress, animated: true)
        progressLabel.text = String(Int(progressLine.progress * 100)) + "%"
    }
    
    
}
