//
//  String+Extensions.swift
//  MoviesAppUIKit
//
//  Created by Thiago Castro on 02/03/26.
//

import Foundation

extension String {
    
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
}
