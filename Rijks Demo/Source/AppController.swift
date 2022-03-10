//
//  AppController.swift
//  Rijks Demo
//
//  Created by Bart on 10/03/2022.
//

import Foundation
import UIKit

final class AppController {

	private lazy var window = {
		UIWindow(frame: UIScreen.main.bounds)
	}()

	func startApp() {

		let initialVC = ViewController()
		window.rootViewController = initialVC
		window.makeKeyAndVisible()
	}
}
