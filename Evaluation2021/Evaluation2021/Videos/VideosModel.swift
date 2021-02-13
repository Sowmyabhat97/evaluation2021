//
//  VideosModel.swift
//  Evaluation2021
//
//  Created by Sowmya on 13/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//
import Foundation

// MARK: - Welcome
struct VideosData: Codable {
    let page, perPage, totalResults: Int?
    let url: String?
    let videos: [Video]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalResults = "total_results"
        case url, videos
    }
}

// MARK: - Video
struct Video: Codable {
    let fullRes: String?
    let tags: [String]?
    let id, width, height: Int?
    let url: String?
    let image: String?
    let duration: Int?
    let avgColor: String?
    let user: User?
    let videoFiles: [VideoFile]?
    let videoPictures: [VideoPicture]?
    
    enum CodingKeys: String, CodingKey {
        case fullRes = "full_res"
        case tags, id, width, height, url, image, duration
        case avgColor = "avg_color"
        case user
        case videoFiles = "video_files"
        case videoPictures = "video_pictures"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name: String?
    let url: String?
}

// MARK: - VideoFile
struct VideoFile: Codable {
    let id: Int?
    let quality: Quality?
    let fileType: FileType?
    let width, height: Int?
    let link: String?
    
    enum CodingKeys: String, CodingKey {
        case id, quality
        case fileType = "file_type"
        case width, height, link
    }
}

enum FileType: String, Codable {
    case videoMp4 = "video/mp4"
}

enum Quality: String, Codable {
    case hd = "hd"
    case hls = "hls"
    case sd = "sd"
}

// MARK: - VideoPicture
struct VideoPicture: Codable {
    let id: Int?
    let picture: String?
    let nr: Int?
}
