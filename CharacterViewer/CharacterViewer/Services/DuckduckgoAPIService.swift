//
//  DuckduckgoAPIService.swift
//  CharacterViewer
//
//  Created by Pradeep on 6/13/23.
//

import Foundation

enum DuckduckgoAPIError: Error {
  case invalidResponse
  case noData
  case failedRequest
  case invalidData
}

class DuckduckgoAPIService {
    typealias DuckduckgoAPIDataCompletion = (Character?, DuckduckgoAPIError?) -> ()
  
    static func getCharacters(urlString: String, completion: @escaping DuckduckgoAPIDataCompletion) {
    let url = URL(string: urlString)!
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      //execute completion handler on main thread
      DispatchQueue.main.async {
        guard error == nil else {
          print("Failed request from DuckduckgoAPI: \(error!.localizedDescription)")
          completion(nil, .failedRequest)
          return
        }
        
        guard let data = data else {
          print("No data returned from DuckduckgoAPI")
          completion(nil, .noData)
          return
        }
        
        guard let response = response as? HTTPURLResponse else {
          print("Unable to process DuckduckgoAPI response")
          completion(nil, .invalidResponse)
          return
        }
        
        guard response.statusCode == 200 else {
          print("Failure response from DuckduckgoAPI: \(response.statusCode)")
          completion(nil, .failedRequest)
          return
        }
        
        do {
          let decoder = JSONDecoder()
          let characterData: Character = try decoder.decode(Character.self, from: data)
          completion(characterData, nil)
        } catch {
          print("Unable to decode DuckduckgoAPI response: \(error.localizedDescription)")
          completion(nil, .invalidData)
        }
      }
    }.resume()
  }
}
