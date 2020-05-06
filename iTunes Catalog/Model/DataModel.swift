//
//  DataModel.swift
//  iTunes Catalog
//
//  Created by KIRILL CHUMAK on 5/4/20.
//  Copyright © 2020 Kirill Chumak. All rights reserved.
//

// MARK: - iTunes API Data Model
struct ITunesAPIResponse: Decodable {
    let results: [Result]
}


enum Kind: String, Codable {
    case featureMovie = "feature-movie"
    case podcast = "podcast"
    case song = "song"
    case book = "book"
    case album = "album"
    case coachedAudio = "coached-audio"
    case interactiveBooklet = "interactive-booklet"
    case musicVideo = "music-video"
    case pdf = "pdf"
    case podcastEpisode = "podcast-episode"
    case softwarePackage = "software-package"
    case tvEpisode = "tv-episode"
    case artist = "artist"
}



// MARK: - Result
struct Result: Decodable {
    
    let kind: Kind?
    let trackID: Int?
    let artistName: String
    let trackViewURL: String?
    let artworkUrl100: String
    let primaryGenreName: String
    
    
    enum CodingKeys: String, CodingKey {
        case kind
        case trackID = "trackId"
        case artistName
        case trackViewURL = "trackViewUrl"
        case artworkUrl100
        case primaryGenreName
    }
}
