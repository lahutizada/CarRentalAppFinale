//
//  TabBarController.swift
//  CarRentalAppFinale
//
//  Created by Ruslan Lahutizada on 29.12.25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarAppearance()
        setupController()
    }
    func setupController() {
        
        let home = storyboard?.instantiateViewController(withIdentifier: "\(MainController.self)") as! MainController
        home.tabBarItem = UITabBarItem(
            title: "Vehicles",
            image: UIImage(named: "vehichle")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "vehichle.fill")?.withRenderingMode(.alwaysOriginal)
        )
        let homeNavigation = UINavigationController(rootViewController: home)
        
        let search = storyboard?.instantiateViewController(withIdentifier: "\(SearchController.self)") as! SearchController
        search.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal),
               selectedImage: UIImage(named: "search.fill")?.withRenderingMode(.alwaysOriginal)
        )
        let searchNavigation = UINavigationController(rootViewController: search)
        
        let favorite = storyboard?.instantiateViewController(withIdentifier: "\(FavoritesController.self)") as! FavoritesController
        favorite.tabBarItem = UITabBarItem(
            title: "Favorite",
            image: UIImage(named: "star")?.withRenderingMode(.alwaysOriginal),
               selectedImage: UIImage(named: "star.fill")?.withRenderingMode(.alwaysOriginal)
        )
        let favoriteNavigation = UINavigationController(rootViewController: favorite)
        
        self.tabBar.backgroundColor = .none
        viewControllers = [homeNavigation, searchNavigation, favoriteNavigation ]
    }
    private func setupTabBarAppearance() {

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear

        let font = UIFont.systemFont(ofSize: 11, weight: .semibold)

        appearance.stackedLayoutAppearance.normal.iconColor = .brandGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .font: font,
            .foregroundColor: UIColor.brandGray
        ]

        appearance.stackedLayoutAppearance.selected.iconColor = .brandBlue
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .font: font,
            .foregroundColor: UIColor.brandBlue
        ]

        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment =
            UIOffset(horizontal: 0, vertical: 4)

        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment =
            UIOffset(horizontal: 0, vertical: 4)

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

}
