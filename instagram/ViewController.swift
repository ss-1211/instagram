//
//  ViewController.swift
//  instagram
//
//  Created by 佐々木駿 on 2019/07/28.
//  Copyright © 2019 shun.sasaki. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpTab()
    }
    
    func setUpTab() {
        let tabBarController: ESTabBarController! = ESTabBarController(tabIconNames: ["home", "camera", "setting"])
        
        tabBarController.selectedColor = UIColor(displayP3Red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        tabBarController.buttonsBackgroundColor = UIColor(displayP3Red: 0.98, green: 0.8, blue: 0.98, alpha: 1)
        tabBarController.selectionIndicatorHeight = 3
        
        addChild(tabBarController)
        let tabBarview = tabBarController.view!
        tabBarview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBarview)
        let safearea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tabBarview.topAnchor.constraint(equalTo: safearea.topAnchor),
            tabBarview.bottomAnchor.constraint(equalTo: safearea.bottomAnchor),
            tabBarview.leadingAnchor.constraint(equalTo: safearea.leadingAnchor),
            tabBarview.trailingAnchor.constraint(equalTo: safearea.trailingAnchor)
            ])
        tabBarController.didMove(toParent: self)
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "Home")
        let settingViewController = storyboard?.instantiateViewController(withIdentifier: "Setting")
        
        tabBarController.setView(homeViewController, at: 0)
        tabBarController.setView(settingViewController, at: 2)
        
        tabBarController.highlightButton(at: 1)
        tabBarController.setAction({
            let imageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageSelect")
            self.present(imageViewController!, animated: true, completion: nil)
        }, at: 1)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser == nil {
            let loginViewController = storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil)
        }
        
    }

}

