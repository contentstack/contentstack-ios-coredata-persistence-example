//
//  SessionListModels.swift
//  ContentstackPersistenceiOS
//
//  Created by Uttam Ukkoji on 14/09/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//

import UIKit
import ContentstackPersistenceCoreData
import CoreData
enum SessionList
{
  // MARK: Use cases
    struct Request
    {
        func getSessions() -> [Session] {
            return AppDelegate.shared.persistentContainer.viewContext.findAll(Session.self)
        }
    }
    
    struct Response
    {
        var sessionArray : [Session]
    }
    
    struct ViewModel
    {
    }
  
}
