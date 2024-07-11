//
//  spezillm_demoApp.swift
//  spezillm_demo
//
//  Created by Leo Lee on 11/7/2024.
//

import SwiftUI
import SpeziLLM

@main
struct spezillm_demoApp: App {
    @ApplicationDelegateAdaptor(DemoAppDelegate.self) var appDelegate
    @State private var llmExists = false
    @State private var llmSession: LLMLocalSession? = nil

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                VStack {
                    if !llmExists {
                        LLMLocalOnboardingDownloadView(llmExists: $llmExists)
                    } else if let session = llmSession {
                        LLMDemoChatView(llmExists: $llmExists, llmSession: session)
                    } else {
                        Text("Loading LLM Session...")
                            .onAppear {
                                initializeLLMSession()
                            }
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
    
    private func initializeLLMSession() {
        do {
            let llmFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("llm.gguf")
            let schema = LLMLocalSchema(modelPath: llmFilePath)
            llmSession = try runner.with(schema)
        } catch {
            print("Error initializing LLM Session: \(error.localizedDescription)")
            // Handle initialization error as needed
        }
    }
}






