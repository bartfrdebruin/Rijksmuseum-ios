//
//  DecodableMapper.swift
//  PINCHNetwork
//
//  Created by Wesley Hilhorst on 11/03/2019.
//

import Foundation

public class DecodableMapper<T: Decodable>: Mapper {

	private let decoder: JSONDecoder

	public init(decoder: JSONDecoder) {
		self.decoder = decoder
	}

	/**
	Create a mapper which can directly map a result with data
	*/
	public func processDataResponse(_ result: Result<NetworkResponse, NetworkError>) -> Result<T, NetworkError> {

		return result.flatMap({ (response) -> Result<T, NetworkError> in

			guard let data = response.data else {
				return .failure(NetworkError.noDataAvailable)
			}

			return processDataAsResult(data)
		})
	}

	/**
	Create a method which can process data and decode it and return it as a result
	*/
	public func processDataAsResult(_ data: Data) -> Result<T, NetworkError> {

		do {

			return .success(try self.processData(data))
		} catch let error {

			return .failure(NetworkError.mappingError(error))
		}
	}

	/**
	Create a method which can process data and decode it
	*/
	public func processData(_ data: Data) throws -> T {

		return try decoder.decode(T.self, from: data)
	}
}
