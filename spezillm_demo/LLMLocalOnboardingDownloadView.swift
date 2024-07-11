//
//  LLMLocalOnboardingDownloadView.swift
//  spezillm_demo
//
//  Created by Leo Lee on 11/7/2024.
//

import SwiftUI
import SpeziLLMLocalDownload

struct LLMLocalOnboardingDownloadView: View {
    @Binding var llmExists: Bool // Binding to control llmExists state
    
    var body: some View {
        LLMLocalDownloadView(
            downloadDescription: "The Llama2 7B model will be downloaded",
            llmDownloadUrl: LLMLocalDownloadManager.LLMUrlDefaults.llama2ChatModelUrl,
            llmStorageUrl: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("llm.gguf")
        ) {
            llmExists = true // Set llmExists to true when download completes
        }
    }
}


#Preview {
    LLMLocalOnboardingDownloadView(llmExists: .constant(false))
}

