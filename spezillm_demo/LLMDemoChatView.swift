//
//  SwiftUIView.swift
//  spezillm_demo
//
//  Created by Leo Lee on 11/7/2024.
//

import SwiftUI
import SpeziLLM
import SpeziLLMLocal

struct LLMLocalDemoView: View {
    @LLMSessionProvider(
        schema: LLMLocalSchema(
            modelPath: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("llm.gguf")
        )
    ) var llm: LLMLocalSession
    @Binding var llmExists: Bool // Binding to llmExists state to observe changes
    
    var body: some View {
        VStack {
            Button(action: {
                removeModel()
            }) {
                Text("Remove Model")
            }
            .padding()
            
            LLMChatView(session: $llm)
        }
    }
    
    private func removeModel() {
        do {
            let llmFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("llm.gguf")
            try FileManager.default.removeItem(at: llmFilePath)
            llmExists = false // Update llmExists state when model is removed
        } catch {
            print("Error removing model: \(error.localizedDescription)")
            // Handle error as needed
        }
    }
}

struct LLMLocalDemoView_Previews: PreviewProvider {
    static var previews: some View {
        LLMLocalDemoView(llmExists: .constant(true)) // Preview with llmExists set to true
    }
}



#Preview {
    LLMLocalDemoView(llmExists: .constant(true))
}
