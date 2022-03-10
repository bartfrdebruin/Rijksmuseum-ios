//
//  URLSessionNetworkTask.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 11/03/2019.
//

import Foundation

public final class URLSessionNetworkTask: NetworkTask {

	public private(set) var isCanceled: Bool = false
	private var subtasks: [NetworkTask] = []

	public let task: URLSessionTask

	public init(task: URLSessionTask) {

		self.task = task
	}

	public func resumeSubtask(_ task: NetworkTask) {

		guard !isCanceled else {
			return
		}

		subtasks.append(task)
		task.resume()
	}

	public func resume() {

		task.resume()
	}

	public func suspend() {

		task.suspend()
	}

	public func cancel() {

		isCanceled = true

		subtasks.forEach { $0.cancel() }
		task.cancel()
	}
}
