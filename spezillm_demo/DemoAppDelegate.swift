//
//  TestAppDelegate.swift
//  spezillm_demo
//
//  Created by Leo Lee on 11/7/2024.
//

import Foundation
import Spezi
import SpeziLLM
import SpeziLLMLocal

class DemoAppDelegate: SpeziAppDelegate {
    override var configuration: Configuration {
        Configuration {
            // Configure the runner responsible for executing LLMs.
            LLMRunner {
                // State the `LLMPlatform`s supported by the `LLMRunner`.
                LLMLocalPlatform()
            }
        }
    }
}
