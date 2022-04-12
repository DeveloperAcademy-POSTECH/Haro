//
//  CommunityEntity.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/08.
//

import Foundation

struct CommunityEntity: Codable {
    let writerName: String
    let writerPhoto: String
    let category: String
    let text: String
    let photo: String
    let like: Int
    let comment: [CommentEntity]
}

struct CommentEntity: Codable {
    let writerName: String
    let writherPhoto: String
    let text: String
    let time: String
}
