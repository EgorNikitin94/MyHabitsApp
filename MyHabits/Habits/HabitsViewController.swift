//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Егор Никитин on 24.11.2020.
//

import UIKit

protocol HabitsViewControllerDelegate: class {
    func updateCollectionView()
}

final class HabitsViewController: UIViewController {
    
    //MARK:- Properties
    
    private lazy var addHabit: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button = .init(barButtonSystemItem: .add, target: self, action: #selector(tapAddHabitButton))
        button.style = .plain
        button.target = self
        button.tintColor = Colors.purple
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = Colors.white
        collection.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.reuseID)
        collection.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.reuseID)
        collection.dataSource = self
        collection.delegate = self
        collection.toAutoLayout()
        return collection
    }()
    
    // MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        collectionView.layoutIfNeeded()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Сегодня"
        navigationItem.rightBarButtonItem = addHabit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    //MARK:- LayoutSettings
    
    private func setupLayout() {
        view.addSubview(collectionView)
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    //MARK:- Actions
    
    @objc private func tapAddHabitButton() {
        let habitViewController = HabitViewController(isEditingController: false)
        habitViewController.delegateMainVC = self
        let habitNavigationViewController = UINavigationController(rootViewController: habitViewController)
        present(habitNavigationViewController, animated: true) {
            print("habit view controller presented successfully")
        }
    }
    
}


// MARK: - Extensions -

extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : HabitsStore.shared.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cellOne: ProgressCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.reuseID, for: indexPath) as! ProgressCollectionViewCell
            cellOne.updateProgressData()
            return cellOne
        } else {
            let cellTwo: HabitCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.reuseID, for: indexPath) as! HabitCollectionViewCell
            
            cellTwo.isOnRoundButton = {
                collectionView.reloadData()
            }
            cellTwo.habit = HabitsStore.shared.habits[indexPath.item]
            return cellTwo
        }
        
        
    }
    
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    private var baseLeftRightInset: CGFloat { return 16 }
    private var baseSectionInset: CGFloat { return 18 }
    private var baseTopBottomInset: CGFloat { return 22 }
    private var baseSecondSectionInset: CGFloat { return 12 }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index path: \(indexPath)")
        if indexPath.section == 1 {
            let habit = HabitsStore.shared.habits[indexPath.item]
            let habitDetailsViewController = HabitDetailsViewController()
            habitDetailsViewController.habit = habit
            self.navigationController?.pushViewController(habitDetailsViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.frame.width - 16 - 16
        let height: CGFloat = indexPath.section == 0 ? 60 : 130
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return baseSecondSectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let bottom: CGFloat = section == 0 ? baseSectionInset : baseTopBottomInset
        let top: CGFloat = section == 0 ? baseTopBottomInset : .zero
        
        return UIEdgeInsets(top: top, left: baseLeftRightInset, bottom: bottom, right: baseLeftRightInset)
    }
    
}

extension HabitsViewController: HabitsViewControllerDelegate {
    func updateCollectionView() {
        collectionView.reloadData()
    }
}
