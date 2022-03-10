//
//  AppDelegate.swift
//  Rijks Demo
//
//  Created by Bart on 10/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	private let appController = AppController()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		appController.startApp()

		return true
	}
}

