// Copyright (c) Microsoft Corporation.
// All rights reserved.
//
// This code is licensed under the MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MSIDAutoRequestController.h"
#import "MSIDSilentTokenRequest.h"
#import "MSIDInteractiveTokenRequest.h"
#import "MSIDInteractiveRequestParameters.h"
#import "MSIDAccountIdentifier.h"

@interface MSIDAutoRequestController()

@end

@implementation MSIDAutoRequestController

#pragma mark - MSIDInteractiveRequestControlling

- (void)acquireTokenImpl:(nonnull MSIDRequestCompletionBlock)completionBlock
{
    MSIDSilentTokenRequest *request = [[MSIDSilentTokenRequest alloc] initWithRequestParameters:self.requestParameters];

    [request acquireTokenWithCompletionHandler:^(id  _Nullable result, NSError * _Nullable error) {

        if (result)
        {
            completionBlock(result, error);
            return;
        }

        // TODO: check if there's any unrecoverable errors that we know of

        // If we didn't get the result, retry with interaction
        MSIDInteractiveTokenRequest *interactiveRequest = [[MSIDInteractiveTokenRequest alloc] initWithRequestParameters:self.interactiveRequestParamaters];
        [interactiveRequest acquireTokenWithCompletionHandler:completionBlock];
    }];
}

@end
