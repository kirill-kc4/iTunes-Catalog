//
//  SelectedResults.swift
//  iTunes Catalog
//
//  Created by KIRILL CHUMAK on 5/4/20.
//  Copyright © 2020 Kirill Chumak. All rights reserved.
//



struct SelectedResults: Decodable {
    
    var songSection: [ItemDetails]?
    var podcastSection: [ItemDetails]?
    var tvEpisodeSection: [ItemDetails]?
    
    var bookSection : [ItemDetails]?
    var albumSection : [ItemDetails]?
    var coachedAudioSection : [ItemDetails]?
    var interactiveBookletArraySection : [ItemDetails]?
    var musicVideoSection : [ItemDetails]?
    
    var pdfSection : [ItemDetails]?
    var podcastEpisodeSection : [ItemDetails]?
    var softwarePackageSection : [ItemDetails]?
    var artistSection : [ItemDetails]?
    var featureMovieSection : [ItemDetails]?
    
}


struct ItemDetails: Codable {
    
    var artistName: String?
    let primaryGenreName: String?
    var artworkUrl: String?
    var trackViewURL: String?
    
}
