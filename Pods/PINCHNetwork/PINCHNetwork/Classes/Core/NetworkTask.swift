//
//  NetworkTask.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 11/03/2019.
//

public protocol NetworkTask {

	var isCanceled: Bool { get }

	func resumeSubtask(_ task: NetworkTask)

	func resume()
	func suspend()
	func cancel()
}
