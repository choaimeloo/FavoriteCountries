//
//  FileManager.swift
//  FavoriteCountries
//
//  Created by Janiffer.Cho on 4/7/21.
//

import Foundation

public extension FileManager {
    static var documentsDirectoryURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
