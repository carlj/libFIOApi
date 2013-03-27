# libFIO

libFIO is a simple utility class for the [forecast.io API](https://developer.darkskyapp.com) . Features:

* Queueing
* Block Request
* Delegate Request

## Adding to your project

1. Add the ```libFIOApi.xcodeproj``` to your XCode Project
2. Add the ```libFIOApi.a``` to your Targets Build Phrases -> Target Dependencies
3. In your Target Build Settings set the ```Header Search Paths``` to the ```libFIOApi``` folder. (e.g $(SRCROOT)/dependencies/libFIOApi/ with the recursiv option)


You don't need to do anything regarding ARC

## Usage

First take a look at the ```ViewController.m``` File in the include example Project!

Create the API Client with your [forecast.io](forecast.io) Key: 
``` objective-c
FIOAPIClient *client = [[FIOAPIClient alloc] initWithAPIKey: @"your api key" ];
```

Example 1: (API Request with the Delegate Methods)
``` objective-c
FIORequestDelegateOperation *delegateOperation = [client forecastOperationWithDelegate:self];
delegateOperation.longitude = @49.9999976071047;
delegateOperation.latitude = @49.9999976071047;

[delegateOperation start];


- (void)operation:(FIORequestDelegateOperation *)operation finishedWithResults:(NSDictionary *)results {
  NSLog(@"%s %@", __FUNCTION__, results);
}
```

Example 2: (API Request with block)
``` objective-c
//Block Example
FIORequestDelegateOperation *blockOperation = [client forecastOperationWithFinishedBlock:^(FIORequestBlockOperation *operation, id response){
  NSLog(@"%s %@", __FUNCTION__, response);
}
failedBlock:^(FIORequestBlockOperation *operation, NSError *error){
NSLog(@"%s %@", __FUNCTION__, error);
}];

blockOperation.longitude = @49.9999976071047;
blockOperation.latitude = @49.9999976071047;

[blockOperation start];
```

Example 3: (API Request for a Specific Time)
``` objective-c
FIORequestDelegateOperation *blockTimeOperation = [client forecastOperationWithFinishedBlock:^(FIORequestBlockOperation *operation, id response){
  NSLog(@"%s %@", __FUNCTION__, response);
}
failedBlock:^(FIORequestBlockOperation *operation, NSError *error){
NSLog(@"%s %@", __FUNCTION__, error);
}];

blockTimeOperation.longitude = @49.9999976071047;
blockTimeOperation.latitude = @49.9999976071047;
blockTimeOperation.date = [NSDate date]; //automaticly convert the NSDate to GMT
[blockTimeOperation start];
```

Example 4: (API Request with SI Units)
``` objective-c
FIORequestDelegateOperation *blockSIOperation = [client forecastOperationWithFinishedBlock:^(FIORequestBlockOperation *operation, id response){
  NSLog(@"%s %@", __FUNCTION__, response);
}
failedBlock:^(FIORequestBlockOperation *operation, NSError *error){
NSLog(@"%s %@", __FUNCTION__, error);
}];

blockSIOperation.longitude = @49.9999976071047;
blockSIOperation.latitude = @49.9999976071047;
blockSIOperation.useSIUnits = YES;
[blockSIOperation start];
```

Example 5: (API Request with a Queue)
``` objective-c
FIORequestDelegateOperation *delegateOperationForQueue = [client forecastOperationWithDelegate:self];
delegateOperationForQueue.longitude = @49.9999976071047;
delegateOperationForQueue.latitude = @49.9999976071047;

[[FIORequestQueue sharedQueue] addOperation: delegateOperationForQueue];

//You can register for the kFIORequestQueueStartedNotificatioName, kFIORequestQueueFinishedNotificatioName and kFIORequestQueueCanceledNotificatioName Notifications
```

## License

libFIO is licensed under the MIT license See the LICENSE file for more info.

## Thanks

Thanks to [@samsoffes](https://twitter.com/samsoffes) for the inspirations!