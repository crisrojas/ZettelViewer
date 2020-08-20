//
//  Array.swift
//  ZettelViewer
//
//  Created by Cristian Rojas on 20/08/2020.
//  Copyright © 2020 Cristian Rojas. All rights reserved.
//

import Foundation


extension Array where Element == Zettel {
    func matching(_ text: String?) -> [Zettel] {
        if let text = text, text.count > 0 {
            return self.filter {
                $0.title.contains(text)
            }
        } else {
            return self
        }
    }
}
