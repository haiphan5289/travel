//
//  tab_bar.swift
//  app_travel
//
//  Created by HaiPhan on 7/31/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class tab_bar: UITabBarController {

    let recent = UINavigationController(rootViewController: my_journis_vc())
    let house = UINavigationController(rootViewController: house_vc())
    let search = UINavigationController(rootViewController: search_vc())
    let noti = UINavigationController(rootViewController: notification())
    let profile = UINavigationController(rootViewController: profile_vc())
    let view_line = UIView()
    let view_display = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
//        let recent = UINavigationController(rootViewController: my_journis_vc())
        recent.tabBarItem.title = "My Journis"
        recent.tabBarItem.image = UIImage(named: "gallery")
        create_vc()
        viewControllers = [recent, house, search, noti, profile]
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor(red: 51/255, green: 101/255, blue: 161/255, alpha: 1)
        recent.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .highlighted)
        if let items = self.tabBar.items
        {
            for item in items
            {
                if let image = item.image
                {
                    item.image = image.withRenderingMode(.alwaysOriginal)
                    item.selectedImage = image.withRenderingMode(.alwaysOriginal)
                }
            }
        }
        view_line_autolayout()
        view_display_autoplayout()
    }
    var width_display: NSLayoutConstraint?
    var left_display: NSLayoutConstraint?
    func view_display_autoplayout(){
        self.tabBar.addSubview(view_display)
        view_display.backgroundColor = UIColor.white
        view_display.alpha = 0.2
        
        view_display.translatesAutoresizingMaskIntoConstraints = false
        left_display = view_display.leftAnchor.constraint(equalTo: self.tabBar.leftAnchor, constant: 0)
        left_display!.isActive = true
        view_display.topAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: 0).isActive = true
        width_display = view_display.widthAnchor.constraint(equalToConstant: 100)
        width_display!.isActive = true
        view_display.bottomAnchor.constraint(equalTo: self.tabBar.bottomAnchor, constant: 0).isActive = true
    }
    
    var left_view: NSLayoutConstraint?
    var width_view: NSLayoutConstraint?
    func view_line_autolayout(){
        tabBar.addSubview(view_line)
        view_line.backgroundColor = UIColor.orange
//        view_line.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        view_line.translatesAutoresizingMaskIntoConstraints = false
        left_view = view_line.leftAnchor.constraint(equalTo: self.tabBar.leftAnchor, constant: 0)
        left_view!.isActive = true
        view_line.topAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: 0).isActive = true
        width_view = view_line.widthAnchor.constraint(equalToConstant: 100)
        width_view!.isActive = true
        view_line.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
    func create_vc(){
        house.tabBarItem.title = "House"
        house.tabBarItem.image = UIImage(named: "house")
        
        search.tabBarItem.title = "Search"
        search.tabBarItem.image = UIImage(named: "search")
        
        noti.tabBarItem.title = "Notification"
        noti.tabBarItem.image = UIImage(named: "comments")
        
        profile.tabBarItem.title = "Profile"
        profile.tabBarItem.image = UIImage(named: "profile")
    }

}
extension tab_bar: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
         let tabBarIndex = tabBarController.selectedIndex
        guard let view = self.tabBar.items?[tabBarIndex].value(forKey: "view") as? UIView else
        {
            return
        }
        switch tabBarIndex {
        case 0:
            move_view(x: view.frame.origin.x, width: view.frame.size.width)
            recent.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .highlighted)
        case 1:
            move_view(x: view.frame.origin.x, width: view.frame.size.width)
            house.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .highlighted)
            hide_text_recent()
        case 2:
            move_view(x: view.frame.origin.x, width: view.frame.size.width)
            search.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .highlighted)
            hide_text_recent()
        case 3:
            move_view(x: view.frame.origin.x, width: view.frame.size.width)
            noti.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .highlighted)
            hide_text_recent()
        default:
            move_view(x: view.frame.origin.x, width: view.frame.size.width)
            profile.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .highlighted)
            hide_text_recent()
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hide_text_recent(){
        recent.tabBarItem.setTitleTextAttributes(nil, for: .highlighted)
    }
    
    func move_view(x: CGFloat, width: CGFloat){
        left_view?.constant = x
        width_view?.constant = width
        left_display?.constant = x
        width_display?.constant = width
    }
}
