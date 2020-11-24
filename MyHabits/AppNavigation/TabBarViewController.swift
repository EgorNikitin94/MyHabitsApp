//
//  TabBarViewController.swift
//  MyHabits
//
//  Created by Егор Никитин on 24.11.2020.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: Properties
    let habitsViewController = UINavigationController(rootViewController: HabitsViewController())
    let infoViewController = UINavigationController(rootViewController: InfoViewController())
    
    let habitsBarItem: UITabBarItem = {
        let habitsBI = UITabBarItem()
        habitsBI.image = UIImage(systemName: "rectangle.grid.1x2")
        habitsBI.selectedImage = UIImage(systemName: "rectangle.grid.1x2.fill")
        habitsBI.title = "Привычки"
        habitsBI.standardAppearance?.selectionIndicatorTintColor = Colors.purple
        return habitsBI
    }()
    
    let infoBarItem: UITabBarItem = {
        let infoBI = UITabBarItem()
        infoBI.image = UIImage(systemName: "info.circle")
        infoBI.selectedImage = UIImage(systemName: "info.circle.fill")
        infoBI.title = "Информация"
        infoBI.standardAppearance?.selectionIndicatorTintColor = Colors.purple
        return infoBI
    }()
    
    // Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        habitsViewController.tabBarItem = habitsBarItem
        infoViewController.tabBarItem = infoBarItem
        
        let tabBarList = [habitsViewController, infoViewController]
        
        viewControllers = tabBarList
    }

}
