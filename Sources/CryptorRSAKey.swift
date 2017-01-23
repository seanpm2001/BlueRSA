//
//  CryptorRSAKey.swift
//  CryptorRSA
//
//  Created by Bill Abt on 1/18/17.
//
//  Copyright © 2017 IBM. All rights reserved.
//
// 	Licensed under the Apache License, Version 2.0 (the "License");
// 	you may not use this file except in compliance with the License.
// 	You may obtain a copy of the License at
//
// 	http://www.apache.org/licenses/LICENSE-2.0
//
// 	Unless required by applicable law or agreed to in writing, software
// 	distributed under the License is distributed on an "AS IS" BASIS,
// 	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// 	See the License for the specific language governing permissions and
// 	limitations under the License.
//

import Foundation

// MARK: -

@available(macOS 10.12, iOS 10.0, *)
public extension CryptorRSA {
	
	// MARK: Class Functions
	
	// MARK: -- Public Key Creation
	
	///
	/// Creates a public key with data.
	///
	/// - Parameters:
	///		- data: 			Key data
	///
	/// - Returns:				New `PublicKey` instance.
	///
	public class func createPublicKey(with data: Data) throws -> PublicKey {
		
		return try PublicKey(with: data)
	}

	///
	/// Creates a key with a base64-encoded string.
	///
	/// - Parameters:
	///		- base64String: 	Base64-encoded key data
	///
	/// - Returns:				New `PublicKey` instance.
	///
	public class func createPublicKey(withBase64 base64String: String) throws -> PublicKey {
		
		guard let data = Data(base64Encoded: base64String, options: [.ignoreUnknownCharacters]) else {
			
			throw Error(code: ERR_INIT_PK, reason: "Couldn't decode base 64 string")
		}
		
		return try PublicKey(with: data)
	}
	
	///
	/// Creates a key with a PEM string.
	///
	/// - Parameters:
	///		- pemString: 		PEM-encoded key string
	///
	/// - Returns:				New `PublicKey` instance.
	///
	public class func createPublicKey(withPEM pemString: String) throws -> PublicKey {
		
		let base64String = try CryptorRSA.base64String(for: pemString)
		
		return try createPublicKey(withBase64: base64String)
	}
	
	///
	/// Creates a key with a PEM file.
	///
	/// - Parameters:
	/// 	- pemName: 			Name of the PEM file
	/// 	- path: 			Path where the file is located.
	///
	/// - Returns:				New `PublicKey` instance.
	///
	public class func createPublicKey(withPEMNamed pemName: String, onPath path: String) throws -> PublicKey {
		
		var fullPath = path.appending(pemName)
		if !path.hasSuffix(PEM_SUFFIX) {
			
			fullPath = fullPath.appending(PEM_SUFFIX)
		}
		
		let keyString = try String(contentsOf: URL(fileURLWithPath: fullPath), encoding: .utf8)
		
		return try createPublicKey(withPEM: keyString)
	}
	
	///
	/// Creates a key with a DER file.
	///
	/// - Parameters:
	/// 	- derName: 			Name of the DER file
	/// 	- path: 			Path where the file is located.
	///
	/// - Returns:				New `PublicKey` instance.
	///
	public class func createPublicKey(withDERNamed derName: String, onPath path: String) throws -> PublicKey {
		
		var fullPath = path.appending(derName)
		if !path.hasSuffix(DER_SUFFIX) {
			
			fullPath = fullPath.appending(DER_SUFFIX)
		}
		
		let data = try Data(contentsOf: URL(fileURLWithPath: fullPath))
		
		return try PublicKey(with: data)
	}
	
	///
	/// Creates a key with a PEM file.
	///
	/// - Parameters:
	/// 	- pemName: 			Name of the PEM file
	/// 	- bundle: 			Bundle in which to look for the PEM file. Defaults to the main bundle.
	///
	/// - Returns:				New `PublicKey` instance.
	///
	public class func createPublicKey(withPEMNamed pemName: String, in bundle: Bundle = Bundle.main) throws -> PublicKey {
		
		guard let path = bundle.path(forResource: pemName, ofType: PEM_SUFFIX) else {
			
			throw Error(code: ERR_INIT_PK, reason: "Couldn't find a PEM file named '\(pemName)'")
		}
		
		let keyString = try String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)
		
		return try createPublicKey(withPEM: keyString)
	}
	
	///
	/// Creates a key with a DER file.
	///
	/// - Parameters:
	/// 	- derName: 			Name of the DER file
	/// 	- bundle: 			Bundle in which to look for the DER file. Defaults to the main bundle.
	///
	/// - Returns:				New `PublicKey` instance.
	///
	public class func createPublicKey(withDERNamed derName: String, in bundle: Bundle = Bundle.main) throws -> PublicKey {
		
		guard let path = bundle.path(forResource: derName, ofType: DER_SUFFIX) else {
			
			throw Error(code: ERR_INIT_PK, reason: "Couldn't find a DER file named '\(derName)'")
		}
		
		let data = try Data(contentsOf: URL(fileURLWithPath: path))
		
		return try PublicKey(with: data)
	}

	// MARK: -- Private Key Creation
	
	///
	/// Creates a private key with data.
	///
	/// - Parameters:
	///		- data: 			Key data
	///
	/// - Returns:				New `PrivateKey` instance.
	///
	public class func createPrivateKey(with data: Data) throws -> PrivateKey {
		
		return try PrivateKey(with: data)
	}
	
	///
	/// Creates a key with a base64-encoded string.
	///
	/// - Parameters:
	///		- base64String: 	Base64-encoded key data
	///
	/// - Returns:				New `PrivateKey` instance.
	///
	public class func createPrivateKey(withBase64 base64String: String) throws -> PrivateKey {
		
		guard let data = Data(base64Encoded: base64String, options: [.ignoreUnknownCharacters]) else {
			
			throw Error(code: ERR_INIT_PK, reason: "Couldn't decode base 64 string")
		}
		
		return try PrivateKey(with: data)
	}
	
	///
	/// Creates a key with a PEM string.
	///
	/// - Parameters:
	///		- pemString: 		PEM-encoded key string
	///
	/// - Returns:				New `PrivateKey` instance.
	///
	public class func createPrivateKey(withPEM pemString: String) throws -> PrivateKey {
		
		let base64String = try CryptorRSA.base64String(for: pemString)
		
		return try CryptorRSA.createPrivateKey(withBase64: base64String)
	}
	
	///
	/// Creates a key with a PEM file.
	///
	/// - Parameters:
	/// 	- pemName: 			Name of the PEM file
	/// 	- path: 			Path where the file is located.
	///
	/// - Returns:				New `PrivateKey` instance.
	///
	public class func createPrivateKey(withPEMNamed pemName: String, onPath path: String) throws -> PrivateKey {
		
		var fullPath = path.appending(pemName)
		if !path.hasSuffix(PEM_SUFFIX) {
			
			fullPath = fullPath.appending(PEM_SUFFIX)
		}
		
		let keyString = try String(contentsOf: URL(fileURLWithPath: fullPath), encoding: .utf8)
		
		return try CryptorRSA.createPrivateKey(withPEM: keyString)
	}
	
	///
	/// Creates a key with a DER file.
	///
	/// - Parameters:
	/// 	- derName: 			Name of the DER file
	/// 	- path: 			Path where the file is located.
	///
	/// - Returns:				New `PrivateKey` instance.
	///
	public class func createPrivateKey(withDERNamed derName: String, onPath path: String) throws -> PrivateKey {
		
		var fullPath = path.appending(derName)
		if !path.hasSuffix(DER_SUFFIX) {
			
			fullPath = fullPath.appending(DER_SUFFIX)
		}
		
		let data = try Data(contentsOf: URL(fileURLWithPath: fullPath))
		
		return try PrivateKey(with: data)
	}
	
	///
	/// Creates a key with a PEM file.
	///
	/// - Parameters:
	/// 	- pemName: 			Name of the PEM file
	/// 	- bundle: 			Bundle in which to look for the PEM file. Defaults to the main bundle.
	///
	/// - Returns:				New `PrivateKey` instance.
	///
	public class func createPrivateKey(withPEMNamed pemName: String, in bundle: Bundle = Bundle.main) throws -> PrivateKey {
		
		guard let path = bundle.path(forResource: pemName, ofType: PEM_SUFFIX) else {
			
			throw Error(code: ERR_INIT_PK, reason: "Couldn't find a PEM file named '\(pemName)'")
		}
		
		let keyString = try String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)
		
		return try CryptorRSA.createPrivateKey(withPEM: keyString)
	}
	
	///
	/// Creates a key with a DER file.
	///
	/// - Parameters:
	/// 	- derName: 			Name of the DER file
	/// 	- bundle: 			Bundle in which to look for the DER file. Defaults to the main bundle.
	///
	/// - Returns:				New `PrivateKey` instance.
	///
	public class func createPrivateKey(withDERNamed derName: String, in bundle: Bundle = Bundle.main) throws -> PrivateKey {
		
		guard let path = bundle.path(forResource: derName, ofType: DER_SUFFIX) else {
			
			throw Error(code: ERR_INIT_PK, reason: "Couldn't find a DER file named '\(derName)'")
		}
		
		let data = try Data(contentsOf: URL(fileURLWithPath: path))
		
		return try PrivateKey(with: data)
	}
	
	// MARK: -
	
	///
	/// RSA Key Creation and Handling
	///
	public class RSAKey {
		
		// MARK: Properties
		
		/// The stored key
		internal let reference: SecKey
		
		/// True if the key is public, false if private.
		public internal(set) var isPublic: Bool = true
		
		// MARK: Initializers
		
		///
		/// Create a key using key data.
		///
		/// - Parameters:
		///		- data: 			Key data
		///		- isPublic:			True the key is public, false otherwise.
		///
		/// - Returns:				New `RSAKey` instance.
		///
		internal init(with data: Data, isPublic: Bool) throws {
			
			self.isPublic = isPublic
			let data = try CryptorRSA.stripPublicKeyHeader(for: data)
			reference = try CryptorRSA.createKey(from: data, isPublic: isPublic)
		}
		
	}
	
	// MARK: -
	
	public class PublicKey: RSAKey {
		
		/// MARK: Statics
		
		/// Regular expression for the PK using the begin and end markers.
		static let publicKeyRegex: NSRegularExpression? = {
			
			let publicKeyRegex = "(\(CryptorRSA.PK_BEGIN_MARKER).+?\(CryptorRSA.PK_END_MARKER))"
			return try? NSRegularExpression(pattern: publicKeyRegex, options: .dotMatchesLineSeparators)
		}()
		
		// MARK: -- Static Functions
		
		///
		/// Takes an input string, scans for public key sections, and then returns a Key for any valid keys found
		/// - This method scans the file for public key armor - if no keys are found, an empty array is returned
		/// - Each public key block found is "parsed" by `publicKeyFromPEMString()`
		/// - should that method throw, the error is _swallowed_ and not rethrown
		///
		/// - Parameters:
		///		- pemString: 		The string to use to parse out values
		///
		/// - Returns: 				An array of `PublicKey` objects containing just public keys.
		///
		public static func publicKeys(withPEM pemString: String) -> [PublicKey] {
			
			// If our regexp isn't valid, or the input string is empty, we can't move forward…
			guard let publicKeyRegexp = publicKeyRegex, pemString.characters.count > 0 else {
				return []
			}
			
			let all = NSRange(
				location: 0,
				length: pemString.characters.count
			)
			
			let matches = publicKeyRegexp.matches(
				in: pemString,
				options: NSRegularExpression.MatchingOptions(rawValue: 0),
				range: all
			)
			
			let keys = matches.flatMap { result -> PublicKey? in
				let match = result.rangeAt(1)
				let start = pemString.characters.index(pemString.startIndex, offsetBy: match.location)
				let end = pemString.characters.index(start, offsetBy: match.length)
				
				let range = Range<String.Index>(start..<end)
				
				let thisKey = pemString[range]
				
				return try? CryptorRSA.createPublicKey(withPEM: thisKey)
			}
			
			return keys
		}
		
		// MARK: -- Initializers
		
		///
		/// Create a public key using key data.
		///
		/// - Parameters:
		///		- data: 			Key data
		///
		/// - Returns:				New `RSAKey` instance.
		///
		public init(with data: Data) throws {
			
			try super.init(with: data, isPublic: true)
		}
	}

	// MARK: -
	
	public class PrivateKey: RSAKey {
		
		// MARK: -- Initializers
		
		///
		/// Create a private key using key data.
		///
		/// - Parameters:
		///		- data: 			Key data
		///
		/// - Returns:				New `RSAKey` instance.
		///
		public init(with data: Data) throws {
			
			try super.init(with: data, isPublic: false)
		}
	}
}
