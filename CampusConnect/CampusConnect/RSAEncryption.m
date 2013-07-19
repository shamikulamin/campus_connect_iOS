//
//  RSAEncryption.m
//  CampusConnect
//
//  Created by Shamikul Amin on 7/11/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "RSAEncryption.h"

@implementation RSAEncryption

- (id)init {
    self = [super init];
    
    NSString *publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key"
                                ofType:@"der"];
    if (publicKeyPath == nil) {
        NSLog(@"Can not find pub.der");
        return nil;
        }
    
    NSDate *publicKeyFileContent = [NSData dataWithContentsOfFile:publicKeyPath];
    if (publicKeyFileContent == nil) {
        NSLog(@"Can not read from pub.der");
        return nil;
        }
    
    certificate = SecCertificateCreateWithData(kCFAllocatorDefault, ( __bridge CFDataRef)publicKeyFileContent);
    if (certificate == nil) {
        NSLog(@"Can not read certificate from pub.der");
        return nil;
        }
    
    policy = SecPolicyCreateBasicX509();
    OSStatus returnCode = SecTrustCreateWithCertificates(certificate, policy, &trust);
    if (returnCode != 0) {
        NSLog(@"SecTrustCreateWithCertificates fail. Error Code: %ld", returnCode);
        return nil;
        }
    
    SecTrustResultType trustResultType;
    returnCode = SecTrustEvaluate(trust, &trustResultType);
    if (returnCode != 0) {
        NSLog(@"SecTrustEvaluate fail. Error Code: %ld", returnCode);
        return nil;
        }
    
    publicKey = SecTrustCopyPublicKey(trust);
    if (publicKey == nil) {
        NSLog(@"SecTrustCopyPublicKey fail");
        return nil;
        }
    
    maxPlainLen = SecKeyGetBlockSize(publicKey) - 12;
    return self;
}

- (NSData *) encryptWithData:(NSData *)content {
    
    size_t plainLen = [content length];
    if (plainLen > maxPlainLen) {
        NSLog(@"content(%ld) is too long, must < %ld", plainLen, maxPlainLen);
        return nil;
        }
    
    void *plain = malloc(plainLen);
    [content getBytes:plain
      length:plainLen];
    
    size_t cipherLen = 256;
    void *cipher = malloc(cipherLen);
    
    OSStatus returnCode = SecKeyEncrypt(publicKey, kSecPaddingPKCS1, plain,
                                         plainLen, cipher, &cipherLen);
    
    NSData *result = nil;
    if (returnCode != 0) {
        NSLog(@"SecKeyEncrypt fail. Error Code: %ld", returnCode);
        }
    else {
        result = [NSData dataWithBytes:cipher
                   length:cipherLen];
        }
    
    return result;
}

- (NSData *) encryptWithString:(NSString *)content {
    return [self encryptWithData:[content dataUsingEncoding:NSUTF8StringEncoding]];
}


@end
