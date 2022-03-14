//
//  State.swift
//  Rijks Demo
//
//  Created by Bart on 14/03/2022.
//

import Foundation

enum State: Equatable {

	case initial
	case loading
	case result
	case error(Error)

	static func == (lhs: State, rhs: State) -> Bool {
		switch (lhs, rhs) {
		case (.initial, .initial): return true
		case (.loading, .loading): return true
		case (.error, .error): return true
		case (.result, .result): return true
		default: return false
		}
	}
}
