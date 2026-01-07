> [!WARNING]
  **This repo is deprecated and no longer maintained. Security updates are not supported. We recommend avoiding its use.** We recommend viewing our latest [Kickstarts](https://www.contentstack.com/docs/developers/kickstarts).
  
# Build an example app using Sync API and Persistence Library with Contentstack’s iOS SDK

The [Persistence Library](https://www.contentstack.com/docs/guide/synchronization/using-realm-persistence-library-with-ios-sync-sdk) lets you store data on the device’s local storage, helping you create apps that can work offline too.

This is an example app built using Contentstack’s iOS SDK, Sync API, and Persistence Library. You can try out and play with our Sync API and data persistence with this example app, before building bigger and better applications.

Perform the steps given below to get started with this app.

## Prerequisites

-   [Xcode 10.1 and later](https://developer.apple.com/xcode/)
-   Mac OS X 10.14.1 and later
-   [Contentstack account](https://www.app.contentstack.com/)
-   [Basic knowledge of Contentstack](https://www.contentstack.com/docs/)

In this tutorial, we will first go through the steps involved in configuring Contentstack and then look at the steps required to customize and use the presentation layer.

## Step 1: Create a stack

Log in to your Contentstack account, and [create a new stack](https://www.contentstack.com/docs/guide/stack#create-a-new-stack). Read more about [stack](https://www.contentstack.com/docs/guide/stack).

## Step 2: Add a publishing environment

[Add a publishing environment](https://www.contentstack.com/docs/guide/environments#add-an-environment) to publish your content in Contentstack. Provide the necessary details as per your requirement. Read more about [environments](https://www.contentstack.com/docs/guide/environments).

## Step 3: Import content types

For this app, we need one content type: Session. Here’s what it is needed for:

-   Session: Lets you add the session content to your app

For quick integration, we have already created the content type. [Download the content types](https://github.com/contentstack/contentstack-ios-coredata-persistence-example/raw/master/Schema/schema.zip) and [import](https://www.contentstack.com/docs/guide/content-types#importing-a-content-type) it to your stack. (If needed, you can [create your own content types](https://www.contentstack.com/docs/guide/content-types#creating-a-content-type). Read more about [Content Types](https://www.contentstack.com/docs/guide/content-types).)

Now that all the content types are ready, let’s add some content for your Stack.

## Step 4: Add content

[Create](https://www.contentstack.com/docs/guide/content-management#add-a-new-entry) and [publish](https://www.contentstack.com/docs/guide/content-management#publish-an-entry) entries for the ‘Session’ content type.

Now that we have created the sample data, it’s time to use and configure the presentation layer.

## Step 5: Clone and configure the application

To get your app up and running quickly, we have created a sample app. Clone the Github repo given below and change the configuration as per your need:
```
$ git clone https://github.com/contentstack/contentstack-ios-coredata-persistence-example.git  
  ```

Now add your Contentstack API Key, Delivery Token, and Environment to the APIManager.swift file within your project. (Find your [Stack's API Key and Delivery Token](https://www.contentstack.com/docs/apis/content-delivery-api/#authentication).)
```
class StackConfig {  
	static var APIKey = "***REMOVED***"  
	static var AccessToken = "DELIVERY_TOKEN"  
	static var EnvironmentName = "ENVIRONMENT"  
	static var _config : Config {  
		get {  
			let config = Config()  
			config.host = "URL"  
			return config  
		}  
	}  
}
```
## Step 6: Install ContentstackPersistenceCoreData iOS Library

You can configure the Persistence Library in two ways – installation using CocoaPods and manual installation.

### Method 1: Using Cocoapods

Add the following command to your Podfile:
```
pod 'ContentstackPersistenceCoreData'
```
  
Then, run the command given below to get the latest release of Contentstack.
```
pod install
```
  
### Method 2: Manual method

1.  Download and set up the Contentstack iOS Persistence Library.
    
```
https://github.com/contentstack/contentstack-ios-persistence.git
  ```

1.  You will find the ContentstackPersistence folder, which contains the following four files:
	-   SyncManager.h
	-   SyncManager.m
	-   SyncPersistable.h
	-   SyncProtocol.h
2.  You will find the ContentstackPersistenceCoredata folder, which contains the following Two files:
	1.  CoreDataStore.h
	2.  CoreDataStore.m
3.  Add the ContentstackPersistence and ContentstackPersistenceCoredata folder to your project.
4.  Add the Bridge.h header file. Import the SyncManager.h file using the command given below:
    
```
#import "SyncManager.h"
```

## Step 7: Map data

There are three important items to be mapped in the synchronization process:
	-   Sync token/pagination token
	-   Entry Mapping
	-   Assets Mapping
Let’s look at how each of the above can be mapped.

### Sync token/pagination token

To save Sync-Token and Pagination-Token create Entity SyncStore in data-model with setting Codegen to Manual/None as follow:
  
![](https://lh4.googleusercontent.com/crMQQ4zQ_m7jGGAumVm03ozVDnOBgDKlmkUJow_rGQ6a4IOPT8C4p-4wPMaN9x7Hf9p9YwzrmiSbITIBQ7Teh1tMnJM6c1qARKRnOBi1N0LqUicsdYOIaovkn0u7CScwKr6ukKHa)

Now select Editor > Create NSManageObject Subclass and create file for SyncStore this will create file for SyncStore class Interface and Implementation. Select SyncStore+CoreDataProperties.swift and add following code to implement SyncStoreProtocol.
```
class SyncStore: NSManagedObject, SyncStoreProtocol {  
	@NSManaged public var paginationToken: String?  
	@NSManaged public var syncToken: String?  
}
```

### Entry Mapping
To begin with, let’s consider an example. Let’s say we have a content types: Session,. Let’s see how to implement the above example.
Create Entity Session in Data-Model as shown in following image:

![](https://lh6.googleusercontent.com/aVBTK8PAy-nwNKW_3WVGXyAL76iPsJRu9LO0zcUxxt_sLqLpfjOam_dCLDB04uKBOiN15GWLwefu6CVQS4I0zljRHBqNH_VUnk4MPlGxYzATJrPi1Bg7CEBrQsZ5Ebt2nDbxsFa6)

Now select Editor > Create NSManageObject Subclass and create file for Session class Interface and Implementation. Open Session+CoreDataProperties.swift file and implement EntryProtocol as shown in following figure.
```
class Session: NSManagedObject, EntryProtocol {  
	@NSManaged public var sessionId: Int64  
	@NSManaged public var type: String?  
	@NSManaged public var title: String?  
	@NSManaged public var desc: String?  
	@NSManaged public var url: String?  
	@NSManaged public var uid: String?  
	@NSManaged public var publishLocale: String?  
	@NSManaged public var createdAt: Date?  
	@NSManaged public var updatedAt: Date?  
	@NSManaged public var locale: String?  
	@NSManaged public var isPopular: Bool  
	@NSManaged public var startTime: Date?  
	@NSManaged public var endTime: Date?  
  
	public static func contentTypeid() -> String! {  
		return  "session"  
	}  
  
	public static func fieldMapping() -> [AnyHashable : Any]! {  
		return ["sessionId":"session_id",  
		"desc": "description",  
		"type":"type",  
		"isPopular":"is_popular",  
		"startTime":"start_time",  
		"endTime":"end_time"]  
	}  
  
	func sessionTime() -> String {  
		var sessionTime = ""  
		if let stime = self.startTime {  
			sessionTime = self.sessionTimeFormatter().string(from: stime)  
			if let eTime = self.endTime {  
				let dateFormatter = DateFormatter()  
				dateFormatter.dateFormat = "h:mm a"  
				sessionTime = "\(sessionTime) - \(dateFormatter.string(from: eTime))"  
			}  
		}  
		return sessionTime  
	}  
  
	private func sessionTimeFormatter() -> DateFormatter {  
		let dateFormatter = DateFormatter()  
		dateFormatter.dateFormat = "EEE MMM d, h:mm a"  
		return dateFormatter  
	}  
}
```

In the above code, we have to implement contentTypeid for which you are mapping the Entry content type.

You also need to implement the fieldMapping function, which returns the mapping of the attributes and entry fields in Contentstack.

Similarly, we can add other entries and perform mapping for each entry.

### Assets Mapping

To save Asset from Contentstack create Entity Assets in data-model with setting Codegen to Manual/None as follow:

![](https://lh3.googleusercontent.com/kFr4Lo1LORqWaJpbJ1DSydfcDekdbQ8GfiFrI1saD06st2VVHvSPx0PGk3Q_445Thc2UcC5laVGJvHcGAbUrCdSJzc1C67MnSjUgatqlX9KXCAupsO_Po4Wy4gbeFVIM5Tl2u5Ps)

Now select Editor > Create NSManageObject Subclass and create file for Assets this will create file for Assets class Interface and Implementation. Select Assets+CoreDataProperties.swift and add following code to implement AssetProtocol.
```
class Assets: NSManagedObject, AssetProtocol{  
	@NSManaged public var publishLocale: String?  
	@NSManaged public var title: String?  
	@NSManaged public var uid: String?  
	@NSManaged public var createdAt: Date?  
	@NSManaged public var updatedAt: Date?  
	@NSManaged public var fileName: String?  
	@NSManaged public var url: String?  
}

  ```

Now, the final step is to initiate SyncManager and begin with the sync process.

## Step 8: Initiate SyncManager and Sync

After content mapping is done, initiate SyncManager by providing the required details:
```
static var stack : Stack = Contentstack.stack(withAPIKey: StackConfig.APIKey, accessToken: StackConfig.AccessToken, environmentName: StackConfig.EnvironmentName, config:StackConfig._config)  
  
static var coredataManager = CoreDataStore(contenxt: AppDelegate.shared.persistentContainer.newBackgroundContext())  
  
var syncManager : SyncManager = SyncManager(stack: stack, persistance: coredataManager)  
  
self.syncManager.sync { (totalCount, loadedCount, error) in  
  
}
```

This will initiate your project.

## More Resources
-   [Getting started with iOS SDK](https://www.contentstack.com/docs/platforms/ios)
-   [Using the Sync API with iOS SDK](https://www.contentstack.com/docs/guide/synchronization/using-the-sync-api-with-ios-sdk)
-   [Using Persistence Library with iOS SDK](https://www.contentstack.com/docs/guide/synchronization/using-realm-persistence-library-with-ios-sync-sdk)
-   [iOS Persistence Library](https://github.com/contentstack/contentstack-iOS-persistence)
