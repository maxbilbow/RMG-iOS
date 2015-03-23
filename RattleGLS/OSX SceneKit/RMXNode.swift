//
//  RMXNode.swift
//  RattleGL
//
//  Created by Max Bilbow on 22/03/2015.
//  Copyright (c) 2015 Rattle Media. All rights reserved.
//

import Foundation


/**
Check whether a file at a given URL has a newer timestamp than a given file.
Example usage:
@code
    NSURL( url1, url2)
    var isNewer = isThisFileNewerThanThatFile(url1, thatURL:url2)
@endcode

@see http://www.dadabeatnik.com for more information.

@param thisURL
    The URL of the source file.
@param thatURL
    The URL of the target file to check.
@return YES if the timestamp of @c thatURL is newer than the timestamp of @c thisURL,
    otherwise NO.
*/
func isThisFileNewerThanThatFile(thisURL: NSURL, thatURL: NSURL ) -> Bool {return true}
class RMXNode : SCNNode {
    
}