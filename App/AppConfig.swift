//
//  AppConfig.swift
//  EnglishCards
//
//  Created by Asael Rodriguez on 22/04/26.
//

enum AppEnvironment {
    case mock
    case production
}

struct AppConfig {
    static var environment: AppEnvironment {
        #if MOCK
            return .mock
        #else
            return .production
        #endif
    }
    
}
