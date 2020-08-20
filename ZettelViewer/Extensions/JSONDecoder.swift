//
//  JSONDecoder.swift
//  ZettelViewer
//
//  Created by Cristian Rojas on 20/08/2020.
//  Copyright © 2020 Cristian Rojas. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, fromURL url: String, completion: @escaping (T) -> Void) {
        
        guard let url = URL(string: url) else {fatalError("Invalid URL")}
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let downloadedData = try self.decode(type, from: data)
                DispatchQueue.main.async {completion(downloadedData)}
            } catch {print(error)}
        }
    }
}

/*
 What the heck is happening here?
 
1. We tell the function that there's going to be a `T` parameter that must conform to the `Decodable` protocol: func decode<T: Decodable>
2. We define the paramers that the function should have:
 
A type: (_ type: T.type, ...)
A string: (..., fromURL url: String)
A function: (..., ...., completion: @escaping (T) -> Void)

As we see, the function should take the same type used before as a parameter.
 
If the url isn't correct we return an error:
 
guard let url = URL(string: url) else {fatalError("Invalid URL")}

If the url is correct, we retrive the data in a different thread:
 
DispatchQueue.global().async { ... }
 
 We try to donwload the data:
 
 1. We define the data: let data = try data(contentsOf: url)
 2. We download it: let downloadedData = try self.decode(type, from: data)
 
 Then we execute our function passed as a parameter (completion handler) and we do it in the main thread:
 
 DispatchQueue.main.async {completion(downloadedData)}
 
 But, what the heck is doing the completion handler?
 
 It's isn't returning nothing. That means that we could do whatever we want on it's body.
 
 however, it's taking the type as a parameter. But what is that exactly?
 
 Well my guess is that the type that we're passing as a parameter is the downloaded data decoded! so we could use it as we please, in this case we're using it to populate an array [Zettels]() in the `ZettelDataSource.swift` file
 */
