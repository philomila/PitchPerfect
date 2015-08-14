//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Qinhan Jiang on 7/27/15.
//  Copyright (c) 2015 VioletJ. All rights reserved.
//

import Foundation

class RecordedAudio{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl:NSURL, title:String){
        self.filePathUrl = filePathUrl
        self.title = title
        
    }
}