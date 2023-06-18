//
//  SceneDelegate.swift
//  Characters
//
//  Created by Uladzislau Komar on 18.06.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let networkManager = NetworkManager()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MainScreen(networkManager: networkManager)
        window?.makeKeyAndVisible()
    }
}

