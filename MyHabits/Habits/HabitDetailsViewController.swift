//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Егор Никитин on 29.11.2020.
//

import UIKit

final class HabitDetailsViewController: UIViewController {
    
    //MARK:- Properties
    
    var habit: Habit
    
    private let cellID = "cellID"
    
    private lazy var editButton: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.title = "Править"
        button.style = .plain
        button.target = self
        button.action = #selector(editButtonTapped)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = Colors.white
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        table.toAutoLayout()
        return table
    }()
    
    
    // MARK:- LifeCycle
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        view.backgroundColor = Colors.white
        navigationItem.title = habit.name
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = editButton
        navigationController?.navigationBar.tintColor = Colors.purple
        
    }
    
    
    // MARK:- LayoutSettings
    
    private func setupLayout() {
        view.addSubview(tableView)
        let constratints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constratints)
    }
    
    
    
    
    @objc func editButtonTapped() {
        print("Edit button tapped")
        
    }
}



extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        var datesStringArray: [String] = []
        
        for (index, _) in HabitsStore.shared.dates.enumerated() {
            let string = HabitsStore.shared.trackDateString(forIndex: index)
            datesStringArray.append(string ?? "")
        }
        
        cell.textLabel?.text = datesStringArray[indexPath.row]
        cell.textLabel?.textColor = .black
        cell.tintColor = Colors.purple
        cell.selectionStyle = .none
        
        for date in HabitsStore.shared.dates {
            if HabitsStore.shared.habit(habit, isTrackedIn: date) == true {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableTitle = "АКТИВНОСТЬ"
        
        return tableTitle
    }
    
    
}
