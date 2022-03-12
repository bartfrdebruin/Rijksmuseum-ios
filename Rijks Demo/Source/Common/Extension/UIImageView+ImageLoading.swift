//
//  UIImageView+Kingfisher.swift
//  Rijks Demo
//
//  Created by Bart on 12/03/2022.
//

import Foundation
import Kingfisher

extension UIImageView {

	func loadURL(_ url: URL, options: KingfisherOptionsInfo? = nil) {

		let options = options ?? [
			.transition(.fade(0.33)),
			.cacheOriginalImage
		]

		kf.indicatorType = .activity

		kf.setImage(
			with: url,
			placeholder: nil,
			options: options
		)
	}
}
