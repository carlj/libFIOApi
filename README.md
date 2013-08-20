# libFIO

libFIO is a simple utility library for the [forecast.io v2 API](https://developer.darkskyapp.com). Features:

* Queueing
* Block Request
* Delegate Request

## Adding to your project

1. ```git clone https://github.com/carlj/libFIOApi.git```
2. ```cd libFIOApi```, ```git submodule init``` and ```git submodule update```
3. Drag and Drop the ```libFIOApi.xcodeproj``` to your XCode Project
4. Add the ```libFIOApi.a``` to your Targets -> Build Phrases -> Target Dependencies
5. In you Target -> Summary add the ```libFIOApi.a``` to the Linked Frameworks and Libraries 
6. In your Target Build Settings set the ```Header Search Paths``` to the ```libFIOApi``` folder. (e.g $(SRCROOT)/dependencies/libFIOApi/ with the recursiv option)


You don't need to do anything regarding to ARC.

## Usage

Bevor you get started you should get a API Key from: [forecast.io Developer Console](https://developer.forecast.io)

First take a look at the ```ViewController.m``` File in the include example Project!

Create the API Client with your [forecast.io](forecast.io) Key: 
``` objective-c
FIOAPIClient *client = [[FIOAPIClient alloc] initWithAPIKey: @"your api key" ];

//or get the shared client
FIOAPIClient *client = [FIOAPIClient sharedAPIClient];
client.apiKey = @"YOUR API KEY";
```

Example 1: (API Request with the Delegate Methods)
``` objective-c
FIORequestDelegateOperation *delegateOperation = [client forecastOperationWithDelegate:self];
delegateOperation.longitude = @49.9999976071047;
delegateOperation.latitude = @49.9999976071047;

[delegateOperation start];


//the finished method from the FIORequestOperationDelegate protocol is required
- (void)operation:(FIORequestDelegateOperation *)operation finishedWithResults:(NSDictionary *)results {
  NSLog(@"%s %@", __FUNCTION__, results);
}

//the error method from the FIORequestOperationDelegate protocol is optional
- (void)operation:(FIORequestDelegateOperation *)operation failedWithError:(NSError *)error {
    NSLog(@"%s %@", __FUNCTION__, error);
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

Example 3: (API Request with block)
``` objective-c
//Block Example
[client requestWithLongitude: @49.9999976071047
                    latitude: @49.9999976071047
                    finished: ^(FIORequestBlockOperation *operation, id response){
                      NSLog(@"%s %@", __FUNCTION__, response);
                    }
                      failed: ^(FIORequestBlockOperation *operation, NSError *error){
                        NSLog(@"%s %@", __FUNCTION__, error);
}];
//You should not start the request manually
```

Example 4: (API Request for a Specific Time)
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

Example 5: (API Request with SI Units)
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

Example 6: (API Request with a Queue)
``` objective-c
FIORequestDelegateOperation *delegateOperationForQueue = [client forecastOperationWithDelegate:self];
delegateOperationForQueue.longitude = @49.9999976071047;
delegateOperationForQueue.latitude = @49.9999976071047;

[[FIORequestQueue sharedQueue] addOperation: delegateOperationForQueue];

//You can register for the kFIORequestQueueStartedNotificatioName, kFIORequestQueueFinishedNotificatioName and kFIORequestQueueCanceledNotificatioName Notifications
```

## License

libFIO is licensed under the MIT license. See the LICENSE file for more info.

## Thanks

Thanks to [@samsoffes](https://twitter.com/samsoffes) for the inspirations!

##ToDo
Rearrange project structur

