//
//  AppDelegate.swift
//  Password Keeper
//
//  Created by David Fisher on 4/11/18.
//  Copyright © 2018 David Fisher. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // To give the iOS status bar light icons & text
    UIApplication.shared.statusBarStyle = .lightContent

    // Programatically initialize the first view controller.
    window = UIWindow(frame: UIScreen.main.bounds)
    FirebaseApp.configure()

    if Auth.auth().currentUser == nil {
        showLoginViewController();
        } else {
          showPasswordViewController();
        }
        window?.makeKeyAndVisible()
        return true
  }

  func handleLogin() {
    showPasswordViewController()
    
  }

  @objc func handleLogout() {
    do {
        try Auth.auth().signOut()
    } catch {
        print("Error on sign out: \(error.localizedDescription)")
    }
    showLoginViewController()
  }

  func showLoginViewController() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    window!.rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
  }

  func showPasswordViewController() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let passwordViewController = storyboard.instantiateViewController(withIdentifier: "PasswordViewController")
    window!.rootViewController = AppNavBar(rootViewController: passwordViewController)
  }
}


extension UIViewController {
  var appDelegate : AppDelegate {
    get {
      return UIApplication.shared.delegate as! AppDelegate
    }
  }
}
