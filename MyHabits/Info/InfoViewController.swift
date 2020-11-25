//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Егор Никитин on 24.11.2020.
//

import UIKit

class InfoViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var infoHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Привычка за 21 день"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.toAutoLayout()
        return label
    }()
    
    private lazy var infoTextLabel: UILabel = {
        let label = UILabel()
        label.text = """
   Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

   1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.

   2. Выдержать 2 дня в прежнем состоянии самоконтроля.

   3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.

   4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

   5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

   6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

   Источник: psychbook.ru
   """
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view =  UIScrollView()
        view.toAutoLayout()
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        return view
    }()
    
    // MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        view.backgroundColor = .white
        title = "Информация"
    }
    
    // MARK:- LayoutSettings
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(infoHeaderLabel)
        contentView.addSubview(infoTextLabel)
        
        let constraints = [
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            infoHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            infoHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            infoTextLabel.topAnchor.constraint(equalTo: infoHeaderLabel.bottomAnchor, constant: 16),
            infoTextLabel.leadingAnchor.constraint(equalTo: infoHeaderLabel.leadingAnchor),
            infoTextLabel.trailingAnchor.constraint(equalTo: infoHeaderLabel.trailingAnchor),
            infoTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
