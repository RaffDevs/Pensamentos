//
//  QuotesManager.swift
//  Pensamentos
//
//  Created by Rafael Veronez Dias on 24/01/23.
//

import Foundation

class QuotesManager {
    var quotes: [Quote] = []
    
    init() {
        loadQuotes()
    }
    
    func loadQuotes() {
        var quoteList: [Quote] = []
        guard let fileURL = Bundle.main.url(forResource: "quotes", withExtension: "json") else { return }
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let jsonDecoder = JSONDecoder()
            quoteList = try jsonDecoder.decode([Quote].self, from: jsonData)
        } catch {
            print("An error happened while trying data from url \(error)")
        }
        
        self.quotes = quoteList
        
    }
    
    func getRandomQuotes() -> Quote {
        let index = Int.random(in: 0...quotes.count - 1)
        return quotes[index]
    }
}
