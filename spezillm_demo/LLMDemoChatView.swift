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
    @Environment(LLMRunner.self) var runner
    @Binding var llmExists: Bool
    @State private var llmSession: LLMLocalSession?

    var body: some View {
        VStack {
            Button(action: {
                removeModel()
            }) {
                Text("Remove Model")
            }
            .padding()
            
            Button(action: {
                llmSession?.cancel()
            }) {
                Text("Interrupt Generation")
            }
            .padding()
            
            if let session = llmSession {
                LLMChatView(session: .constant(session))
            } else {
                Text("LLM Session not initialized")
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            initializeLLMSession()
        }
    }
    
    private func initializeLLMSession() {
            let modelURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("llm.gguf")
        llmSession = runner(with:LLMLocalSchema(modelPath: modelURL, 
                                                parameters: LLMLocalParameters(useMlock: true)
//                                                ,
//                                                formatChat: LLMLocalSchema.PromptFormattingDefaults.llama2
                                               ))
    }
    
    private func removeModel() {
        do {
            llmSession!.cancel()
            let llmFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("llm.gguf")
            try FileManager.default.removeItem(at: llmFilePath)
            llmExists = false
            llmSession = nil
        } catch {
            print("Error removing model: \(error.localizedDescription)")
        }
    }
}

#if DEBUG
struct LLMDemoChatView_Previews: PreviewProvider {
    static var previews: some View {
        LLMDemoChatView(llmExists: .constant(true))
    }
}
#endif

