//
//  SwiftUIView.swift
//  spezillm_demo
//
//  Created by Leo Lee on 11/7/2024.
//

import SwiftUI
import SpeziLLM
import SpeziLLMLocal

struct LLMDemoChatView: View {
    @LLMSessionProvider(
        schema: LLMLocalSchema(
            modelPath: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("llm.gguf")
        )
    ) var llmSession: LLMLocalSession
    @Binding var llmExists: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                removeModel()
            }) {
                Text("Remove Model")
            }
            .padding()
            
            Button(action: {
                llmSession.cancel()
            }) {
                Text("Interrupt Generation")
            }
            .padding()
            
            LLMChatView(session: $llmSession)
        }
    }
    
    private func removeModel() {
        do {
            let llmFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("llm.gguf")
            try FileManager.default.removeItem(at: llmFilePath)
            llmExists = false // Update llmExists state when model is removed
            llmSession.cancel()
        } catch {
            print("Error removing model: \(error.localizedDescription)")
            // Handle error as needed
        }
    }
}




#Preview {
    LLMDemoChatView(llmExists: .constant(true))
}
