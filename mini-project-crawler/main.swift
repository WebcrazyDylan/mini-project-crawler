//
//  main.swift
//  mini-project-crawler
//
//  Created by Dylan Park on 2021-07-30.
//

import Foundation

let fileManager = FileManager.default
let path = fileManager.currentDirectoryPath
let pathURL = URL(string: path)

func printFilePath(path: URL, prefix: String) {
    do {
        let items = try fileManager.contentsOfDirectory(at: path, includingPropertiesForKeys: [URLResourceKey.isDirectoryKey])

        for (index, item) in items.enumerated() {
            let isDir = (try item.resourceValues(forKeys: [.isDirectoryKey])).isDirectory
            
            if index == items.count - 1 {
                print(prefix + "└─ \(item.lastPathComponent)")
                if isDir == true {
                    printFilePath(path: item, prefix: prefix + "      ")
                }

            } else {
                print(prefix + "├─ \(item.lastPathComponent)")
                if isDir == true {
                    printFilePath(path: item, prefix: prefix + "│     ")
                }
            }
        }
    } catch {
        print("Reading failed.")
    }
}

if fileManager.fileExists(atPath: path, isDirectory: nil) == true {
    print(path)
    printFilePath(path: pathURL!, prefix: "")
}
