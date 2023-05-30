//
//  ErrorModal.swift
//  NewProject
//
//  Created by Tarannum Kadri on 23/01/02.
//  Copyright © 2021. All rights reserved.
//

import Foundation

enum ServerError: Error {
    case InvalidURL
}

struct ErrorModal: Error {
   
    var code: Int
    var errorDescription: String
    
    init(code: Int, errorDescription: String) {
        self.code = code
        self.errorDescription = errorDescription
    }
}
