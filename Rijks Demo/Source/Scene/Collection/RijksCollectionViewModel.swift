//
//  RijksCollectionViewModel.swift.swift
//  Rijks Demo
//
//  Created by Bart on 11/03/2022.
//

import Foundation
import PINCHNetwork

final class RijksCollectionViewModel {

	private let networkManager = NetworkManager(
		environment: RijksEnvironment(),
		requestProvider: AlamofireRequestProvider()
	)
}
