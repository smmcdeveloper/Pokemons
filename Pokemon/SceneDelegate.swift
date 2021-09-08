//
//  SceneDelegate.swift
//  Pokemon
//
//  Created by SMMC on 05/09/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let listViewController = ListViewController()
        listViewController.modalPresentationStyle = .fullScreen
        let navigation = UINavigationController(rootViewController: listViewController)
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}

