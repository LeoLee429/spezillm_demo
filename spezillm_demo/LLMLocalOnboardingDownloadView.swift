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
            llmDownloadUrl: getModelUrl,
            llmStorageUrl: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("llm.gguf")
        ) {
            llmExists = true // Set llmExists to true when download completes
        }
    }
    
    private var getModelUrl: URL {
        guard let url = URL(string: "https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGUF/resolve/main/llama-2-7b-chat.Q2_K.gguf") else {
            preconditionFailure("""
                SpeziLLM: Invalid LLMUrlDefaults LLM download URL.
            """)
        }
    
        return url
//        return LLMLocalDownloadManager.LLMUrlDefaults.llama3InstructModelUrl
    }
}


#Preview {
    LLMLocalOnboardingDownloadView(llmExists: .constant(false))
}

