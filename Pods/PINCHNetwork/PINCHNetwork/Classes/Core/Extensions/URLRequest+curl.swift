//
//  URLRequest+curl.swift
//  PINCHNetwork
//
//  Created by Saren Inden on 28/01/2022.
//

import Foundation

extension URLRequest {

	/**
	 Hint: if you print this in the terminal it will be strangely formatted due to how multiline swift strings are printed. This can be solved by casting it to NSString
	 example: `po request.curl() as! NSString`
	 */
	public func cURL(pretty: Bool = true) -> String {

		let newLine = pretty ? "\\\n" : ""
		let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
		let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"

		var cURL = "curl "
		var header = ""
		var data: String = ""

		if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.isEmpty == false {

			httpHeaders.forEach { key, value in

				header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
			}
		}

		if let bodyData = self.httpBody,
		   let bodyString = String(data: bodyData, encoding: .utf8),
		   bodyString.isEmpty == false {
			data = "--data '\(bodyString)'"
		}

		cURL += method + url + header + data

		return cURL
	}
}
