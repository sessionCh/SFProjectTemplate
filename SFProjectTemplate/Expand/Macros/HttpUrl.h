//
//  HttpUrl.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/19.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#ifndef HttpUrl_h
#define HttpUrl_h

#define SFKBaseURL      @"https://m.sunfobank.com"

#define SFKImageUrl(imageUrl) [SFKBaseURL stringByAppendingPathComponent:imageUrl]

#define SFKURL_BorrowApp                @"/borrow/app/"
#define SFKURL_AppMy                    @"/app/my"

#endif /* HttpUrl_h */
