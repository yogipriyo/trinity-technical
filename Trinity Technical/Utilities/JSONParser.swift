//
//  JSONParser.swift
//  Trinity Technical
//
//  Created by Yogi Priyo Prayogo on 15/04/23.
//

import Foundation

struct JSONParser {
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(Contact.self,from: jsonData)
            
            print("Title: ", decodedData.id)
            print("Description: ", decodedData.firstName)
            print("===================================")
        } catch {
            print("decode error")
        }
    }
}
