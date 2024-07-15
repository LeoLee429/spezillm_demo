//
//  FileManagerExtension.swift
//  spezillm_demo
//
//  Created by Leo Lee on 11/7/2024.
//

import Foundation

extension FileManager {
    static var llmFileURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("llm.gguf")
    }
}

