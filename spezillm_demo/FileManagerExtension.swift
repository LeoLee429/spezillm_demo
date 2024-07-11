//
//  FileManagerExtension.swift
//  spezillm_demo
//
//  Created by Leo Lee on 11/7/2024.
//

import Foundation

extension FileManager {
    static var llmFileURL: URL {
        do {
            let directoryURL = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            // Check if the directory exists, create if it doesn't
            if !FileManager.default.fileExists(atPath: directoryURL.path) {
                try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
            }
            
            return directoryURL.appendingPathComponent("llm.gguf")
        } catch {
            fatalError("Failed to obtain LLMDirectoryURL: \(error)")
        }
    }
}

