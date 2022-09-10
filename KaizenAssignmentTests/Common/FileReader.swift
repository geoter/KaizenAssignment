//
//  FileReader.swift
//  KaizenAssignmentTests
//
//  Created by George Termentzoglou on 10/9/22.
//

import Foundation

class FileReader {
    func read(from path: String) -> Data? {
        let testBundle = Bundle(for: FileReader.self)
        let components = path.split(separator: ".")
        assert(components.count == 2)
        let resource = String(describing: components[0])
        let filetype = String(components[1])
        let filepath = testBundle.path(forResource: resource, ofType: filetype)
        let urlFilepath = URL(fileURLWithPath: filepath!)
        return try? Data(contentsOf: urlFilepath)
    }
}
