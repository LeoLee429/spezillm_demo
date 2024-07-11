//
//  spezillm_demoApp.swift
//  spezillm_demo
//
//  Created by Leo Lee on 11/7/2024.
//

import SwiftUI
import Spezi

@main
struct spezillm_demoApp: App {
    @ApplicationDelegateAdaptor(DemoAppDelegate.self) var appDelegate
    @State private var llmExists = false

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                VStack {
                    if !llmExists {
                        LLMLocalOnboardingDownloadView(llmExists: $llmExists).spezi(appDelegate)
                    } else {
                        LLMDemoChatView(llmExists: $llmExists).spezi(appDelegate)
                    }
                }
                .navigationTitle("SpeziLLM Demo")
            }
            .onAppear {
                checkLLMFile()
            }
        }
    }
    
    private func checkLLMFile() {
        let llmFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("llm.gguf")
        llmExists = FileManager.default.fileExists(atPath: llmFilePath.path)
    }
}






