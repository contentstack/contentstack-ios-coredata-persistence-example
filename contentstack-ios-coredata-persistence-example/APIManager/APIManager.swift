//
//  APIManager.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 13/08/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import UIKit
import Contentstack
import ContentstackPersistenceCoreData

class StackConfig {
    static var APIKey           = "***REMOVED***"
    static var AccessToken      = "***REMOVED***"
    static var EnvironmentName  = "web"
    static var _config : Config {
        get {
            let config = Config()
            //            config.host = "URL"
            return config
        }
    }
}

enum APIManger {
    
    static var coredataManager = CoreDataStore(contenxt: AppDelegate.shared.persistentContainer.newBackgroundContext())
    static var stack : Stack = Contentstack.stack(withAPIKey: StackConfig.APIKey, accessToken: StackConfig.AccessToken, environmentName: StackConfig.EnvironmentName, config:StackConfig._config)
    
    static var syncManager : SyncManager = SyncManager(stack: APIManger.stack, persistance: APIManger.coredataManager!)

    static func sync () {
        self.syncManager.sync({ (percentage, isSynccompleted, error) in
            
        })
    }
}
