//
//  SceneDelegate.swift
//  AlefTest
//
//  Created by Артем Соловьев on 24.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        setupWindow(scene: scene)
    }
    
    private func setupWindow(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let controller = ViewController()
        window?.rootViewController = controller
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
}

