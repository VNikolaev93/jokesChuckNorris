//
//  ViewController.swift
//  jokesNorris
//
//  Created by Вячеслав Николаев on 18.11.2019.
//  Copyright © 2019 Вячеслав Николаев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    let tabBarVC = UITabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarVC()
    }
    
    func createTabBarVC() {
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()
        
        let item1 = UITabBarItem(title: "Jokes", image: UIImage(named: "tabBarOne.png"), selectedImage: UIImage(named: "tabBarOne.png"))
        let item2 = UITabBarItem(title: "API", image: UIImage(named: "tabBarTwo.png"), selectedImage: UIImage(named: "tabBarTwo.png"))
        
        firstVC.tabBarItem = item1
        secondVC.tabBarItem = item2
        
        tabBarVC.viewControllers = [firstVC, secondVC]
        
        self.view.addSubview(tabBarVC.view)
    }
}

