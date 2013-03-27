# libFIO

libFIO is a simple utility class for the [forecast.io API](https://developer.darkskyapp.com) . Features:

* Queueing
* Block Request
* Delegate Request

## Adding to your project

1. Add `SSZipArchive.h`, `SSZipArchive.m`, and `minizip` to your project.
2. Add the `libz` library to your target

You don't need to do anything regarding ARC

## Usage

First take a look at the ```ViewController.m``` File in the include example Project!

Initialisation: 
``` objective-c
FIOAPIClient *client = [[FIOAPIClient alloc] initWithAPIKey: @"your api key" ];
```

Example 1:
``` objective-c
FIORequestDelegateOperation *delegateOperation = [client forecastOperationWithDelegate:self];
delegateOperation.longitude = @49.9999976071047;
delegateOperation.latitude = @49.9999976071047;

[delegateOperation start];
```

Example 2:
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

Example 3:
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

Example 4:
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
## License

libFIO is licensed under the [MIT license](https://github.com/samsoffes/ssziparchive/raw/master/LICENSE).

## Thanks

Thanks to [@samsoffes](https://twitter.com/samsoffes) for the inspirations!