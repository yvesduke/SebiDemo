//
//  SceneDelegate.swift
//  DrSebi
//
//  Created by Yves Dukuze on 18/10/2023.
//

import UIKit
import SwiftUI
import ComposableArchitecture

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var homeTabNavigationController : UINavigationController!
    var herbsTabNavigationControoller : UINavigationController!
    var foodsTabNavigationController : UINavigationController!
    
    
    func scene(_ scene: UIScene,
                   willConnectTo session: UISceneSession,
                   options connectionOptions: UIScene.ConnectionOptions) {
            
            guard let windowScene = scene as? UIWindowScene else { return }
            window = UIWindow(windowScene: windowScene)
            
            let tabBarController = UITabBarController()

            let homeVC = UINavigationController(rootViewController: HomeViewController())
            homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
            
            let herbsVC = UINavigationController(rootViewController: HerbsViewController())
            herbsVC.tabBarItem = UITabBarItem(title: "Herbs", image: UIImage(systemName: "leaf"), tag: 1)
            
            let store = Store(
                initialState: FoodsFeature.State(),
                reducer: { FoodsFeature() }
            )
            let foodsView = FoodsView(store: store)
            let foodsHostingController = UIHostingController(rootView: foodsView)
            foodsHostingController.tabBarItem = UITabBarItem(title: "Foods", image: UIImage(systemName: "fork.knife"), tag: 2)
            
            tabBarController.viewControllers = [homeVC, herbsVC, foodsHostingController]
            
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

