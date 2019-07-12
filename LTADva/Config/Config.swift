//
//  Config.swift
//  LTADva
//
//  Created by Branislav Manojlovic on 4/21/1398 AP.
//  Copyright © 1398 Branislav Manojlovic. All rights reserved.
//

import Foundation

//1.
class Config {
    
    static var instance = Config()
    
    private init() { }
    
    var apiURL: URL {
        let urlString: String
        #if DEVELOP
        urlString = "https://joinin-test.eemaginedev.com/"
        #elseif BETA
        urlString = "https://joinin-test.eemaginedev.com/"
        #else
        urlString = "https://joinin-test.eemaginedev.com/"
        #endif
        return URL(string: urlString)!
    }
}
