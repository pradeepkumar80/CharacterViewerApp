//
//  CharacterViewModel.swift
//  CharacterViewer
//
//  Created by Pradeep on 6/13/23.
//

import Foundation

public class CharacterViewModel {
    var characterData: Character? = nil
    
    #if DEBUG
        let urlString = "http://api.duckduckgo.com/?q=simpsons+characters&format=json"
    #else
        let urlString = "http://api.duckduckgo.com/?q=the+wire+characters&format=json"
    #endif
    
    
    var didGetData: ()->Void = {}
    var hasError: ()->Void = {}
    
    func fetchCharactersData() {
        DuckduckgoAPIService.getCharacters(urlString: urlString) { [weak self] (characterData, error) in
            guard
                let self = self,
                let characterData = characterData
            else {
                return
            }
            if error == nil {
                self.characterData = characterData
                didGetData()
            } else {
                hasError()
            }
            
        }
    }
}
