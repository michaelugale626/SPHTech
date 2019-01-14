//
//  RecordsManager.h
//  sphtech
//
//  Created by Michael Ugale on 1/15/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordsManager : NSObject
    
    @property (nonatomic, strong) NSString *recordID;
    @property (nonatomic, strong) NSString *recordQuarter;
    @property (nonatomic, strong) NSString *recordVolume;

@end
