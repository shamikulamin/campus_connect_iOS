//
//  RSAEncryption.h
//  CampusConnect
//
//  Created by Shamikul Amin on 7/11/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAEncryption : NSObject {
    SecKeyRef publicKey;
    
    SecCertificateRef certificate;
    
    SecPolicyRef policy;
    
    SecTrustRef trust;
    
    size_t maxPlainLen;
    
}

- (NSData *) encryptWithData:(NSData *)content;

- (NSData *) encryptWithString:(NSString *)content;

@end
