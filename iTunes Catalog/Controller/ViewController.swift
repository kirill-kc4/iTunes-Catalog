//
//  ViewController.swift
//  iTunes Catalog
//
//  Created by KIRILL CHUMAK on 5/4/20.
//  Copyright © 2020 Kirill Chumak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    var headerTitles = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var dataJSONFile: ITunesAPIResponse?
    private let apiSearchRequestURL = "bill+gates"
    
    var sortedResults: SelectedResults?
    
    
    // MARK: View controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = "Bill Gates"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        getDataAndParseJSON(searchString: apiSearchRequestURL)
        tableView.reloadData()
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Networking & Parsing JSON
    fileprivate func getDataAndParseJSON(searchString: String) {
        if let url = URL(string: "https://itunes.apple.com/search?term="+searchString) {
            do {
                let data = try Data(contentsOf: url)
                self.dataJSONFile = try JSONDecoder().decode(ITunesAPIResponse.self, from: data)
                
                //Sort and show user
                sortAPIResponseByKinds()
                
            } catch let error1 {
                print(error1)
            }
        } else {
            print("JSON file doesnt exists")
        }
    }
    
    
    
    
    func sortAPIResponseByKinds() {
        
        var songArray = [ItemDetails]()
        var podcastArray = [ItemDetails]()
        var tvEpisodeArray = [ItemDetails]()
        var bookArray = [ItemDetails]()
        var albumArray = [ItemDetails]()
        var coachedAudioArray = [ItemDetails]()
        var interactiveBookletArray = [ItemDetails]()
        var musicVideoArray = [ItemDetails]()
        var pdfArray = [ItemDetails]()
        var podcastEpisodeArray = [ItemDetails]()
        var softwarePackageArray = [ItemDetails]()
        var artistArray = [ItemDetails]()
        var featureMovieArray = [ItemDetails]()
        
        //Iterate on response from itunes
        guard let unwrapJSON = dataJSONFile else{
            return
        }
        
        if unwrapJSON.results.count > 0 {
            
            for i in 0...unwrapJSON.results.count-1 {
                
                switch dataJSONFile?.results[i].kind {
                case .book:
                    let itemDetail = ItemDetails(artistName: dataJSONFile?.results[i].artistName, primaryGenreName: dataJSONFile?.results[i].primaryGenreName, artworkUrl: dataJSONFile?.results[i].artworkUrl100, trackViewURL: dataJSONFile?.results[i].trackViewURL)
                    bookArray.append(itemDetail)
                case .album:
                    let itemDetail = ItemDetails(artistName: dataJSONFile?.results[i].artistName, primaryGenreName: dataJSONFile?.results[i].primaryGenreName, artworkUrl: dataJSONFile?.results[i].artworkUrl100, trackViewURL: dataJSONFile?.results[i].trackViewURL)
                    albumArray.append(itemDetail)
                case .coachedAudio:
                    let itemDetail = ItemDetails(artistName: dataJSONFile?.results[i].artistName, primaryGenreName: dataJSONFile?.results[i].primaryGenreName, artworkUrl: dataJSONFile?.results[i].artworkUrl100, trackViewURL: dataJSONFile?.results[i].trackViewURL)
                    coachedAudioArray.append(itemDetail)
                case .interactiveBooklet:
                    let itemDetail = ItemDetails(artistName: dataJSONFile?.results[i].artistName, primaryGenreName: dataJSONFile?.results[i].primaryGenreName, artworkUrl: dataJSONFile?.results[i].artworkUrl100, trackViewURL: dataJSONFile?.results[i].trackViewURL)
                    interactiveBookletArray.append(itemDetail)
                case .musicVideo:
                    let itemDetail = ItemDetails(artistName: dataJSONFile?.results[i].artistName, primaryGenreName: dataJSONFile?.results[i].primaryGenreName, artworkUrl: dataJSONFile?.results[i].artworkUrl100, trackViewURL: dataJSONFile?.results[i].trackViewURL)
                    musicVideoArray.append(itemDetail)
                case .pdf:
                    let itemDetail = ItemDetails(artistName: dataJSONFile?.results[i].artistName, primaryGenreName: dataJSONFile?.results[i].primaryGenreName, artworkUrl: dataJSONFile?.results[i].artworkUrl100, trackViewURL: dataJSONFile?.results[i].trackViewURL)
                    pdfArray.append(itemDetail)
                case .podcastEpisode:
                    let itemDetail = ItemDetails(artistName: dataJSONFile?.results[i].artistName, primaryGenreName: dataJSONFile?.results[i].primaryGenreName, artworkUrl: dataJSONFile?.results[i].artworkUrl100, trackViewURL: dataJSONFile?.results[i].trackViewURL)
                    podcastEpisodeArray.append(itemDetail)
                case .softwarePackage:
                    let itemDetail = ItemDetails(artistName: dataJSONFile?.results[i].artistName, primaryGenreName: dataJSONFile?.results[i].primaryGenreName, artworkUrl: dataJSONFile?.results[i].artworkUrl100, trackViewURL: dataJSONFile?.results[i].trackViewURL)
                    softwarePackageArray.append(itemDetail)
                case .artist:
                    let itemDetail = ItemDetails(artistName: dataJSONFile?.results[i].artistName, primaryGenreName: dataJSONFile?.results[i].primaryGenreName, artworkUrl: dataJSONFile?.results[i].artworkUrl100, trackViewURL: dataJSONFile?.results[i].trackViewURL)
                    artistArray.append(itemDetail)
                case .featureMovie:
                    let itemDetail = ItemDetails(artistName: dataJSONFile?.results[i].artistName, primaryGenreName: dataJSONFile?.results[i].primaryGenreName, artworkUrl: dataJSONFile?.results[i].artworkUrl100, trackViewURL: dataJSONFile?.results[i].trackViewURL)
                    featureMovieArray.append(itemDetail)
                case .song:
                    let itemDetail = ItemDetails(artistName: dataJSONFile?.results[i].artistName, primaryGenreName: dataJSONFile?.results[i].primaryGenreName, artworkUrl: dataJSONFile?.results[i].artworkUrl100, trackViewURL: dataJSONFile?.results[i].trackViewURL)
                    songArray.append(itemDetail)
                case .podcast:
                    let itemDetail = ItemDetails(artistName: dataJSONFile?.results[i].artistName, primaryGenreName: dataJSONFile?.results[i].primaryGenreName, artworkUrl: dataJSONFile?.results[i].artworkUrl100, trackViewURL: dataJSONFile?.results[i].trackViewURL)
                    podcastArray.append(itemDetail)
                case .tvEpisode:
                    let itemDetail = ItemDetails(artistName: dataJSONFile?.results[i].artistName, primaryGenreName: dataJSONFile?.results[i].primaryGenreName, artworkUrl: dataJSONFile?.results[i].artworkUrl100, trackViewURL: dataJSONFile?.results[i].trackViewURL)
                    
                    
                    
                    
                    tvEpisodeArray.append(itemDetail)
                    
                default:
                    print("default no value")
                }
                
            }
            
        }
        
        let sortedResultsInit = SelectedResults.init(songSection: songArray, podcastSection: podcastArray, tvEpisodeSection: tvEpisodeArray, bookSection: bookArray, albumSection: albumArray, coachedAudioSection: coachedAudioArray, interactiveBookletArraySection: interactiveBookletArray, musicVideoSection: musicVideoArray, pdfSection: pdfArray, podcastEpisodeSection: podcastEpisodeArray, softwarePackageSection: softwarePackageArray, artistSection: artistArray, featureMovieSection: featureMovieArray)
        
        sortedResults = sortedResultsInit
        
        processResponseForTableView()
    }
    
    
    func processResponseForTableView() {
        //Calculate number of sections and get titles
        
        if (sortedResults?.songSection!.count)! > 0 {
            headerTitles.append(Kind.song.rawValue)
        }
        if (sortedResults?.podcastSection!.count)! > 0 {
            headerTitles.append(Kind.podcast.rawValue)
        }
        if (sortedResults?.tvEpisodeSection!.count)! > 0 {
            headerTitles.append(Kind.tvEpisode.rawValue)
        }
        if (sortedResults?.bookSection!.count)! > 0 {
            headerTitles.append(Kind.book.rawValue)
            
        }
        if (sortedResults?.albumSection!.count)! > 0 {
            headerTitles.append(Kind.album.rawValue)
        }
        if (sortedResults?.coachedAudioSection!.count)! > 0 {
            headerTitles.append(Kind.coachedAudio.rawValue)
        }
        if (sortedResults?.interactiveBookletArraySection!.count)! > 0 {
            headerTitles.append(Kind.interactiveBooklet.rawValue)
        }
        if (sortedResults?.musicVideoSection!.count)! > 0 {
            headerTitles.append(Kind.musicVideo.rawValue)
        }
        if (sortedResults?.pdfSection!.count)! > 0 {
            headerTitles.append(Kind.pdf.rawValue)
        }
        if (sortedResults?.podcastEpisodeSection!.count)! > 0 {
            headerTitles.append(Kind.podcastEpisode.rawValue)
        }
        if (sortedResults?.softwarePackageSection!.count)! > 0 {
            headerTitles.append(Kind.softwarePackage.rawValue)
        }
        if (sortedResults?.artistSection!.count)! > 0 {
            headerTitles.append(Kind.artist.rawValue)
        }
        if (sortedResults?.featureMovieSection!.count)! > 0 {
            headerTitles.append(Kind.featureMovie.rawValue)
        }
        
        
    }
    
    //Calculate number of rows per each section
    func getNumberOfRowsForEachSection(sectionNumber: Int) -> Int {
        
        let sectionTitleName = headerTitles[sectionNumber]
        
        if sectionTitleName == "song" {
            return sortedResults?.songSection?.count ?? 0
        }
        if sectionTitleName == "podcast" {
            return sortedResults?.podcastSection?.count ?? 0
        }
        if sectionTitleName == "tv-episode" {
            return sortedResults?.tvEpisodeSection?.count ?? 0
        }
        if sectionTitleName == "book" {
            return sortedResults?.bookSection?.count ?? 0
        }
        if sectionTitleName == "album" {
            return sortedResults?.albumSection?.count ?? 0
        }
        if sectionTitleName == "coached-audio" {
            return sortedResults?.coachedAudioSection?.count ?? 0
        }
        if sectionTitleName == "interactive-booklet" {
            return sortedResults?.interactiveBookletArraySection?.count ?? 0
        }
        if sectionTitleName == "music-video" {
            return sortedResults?.musicVideoSection?.count ?? 0
        }
        if sectionTitleName == "pdf" {
            return sortedResults?.pdfSection?.count ?? 0
        }
        if sectionTitleName == "podcast-episode" {
            return sortedResults?.podcastEpisodeSection?.count ?? 0
        }
        
        if sectionTitleName == "software-package" {
            return sortedResults?.softwarePackageSection?.count ?? 0
        }
        
        if sectionTitleName == "artist" {
            return sortedResults?.artistSection?.count ?? 0
        }
        
        if sectionTitleName == "feature-movie" {
            return sortedResults?.featureMovieSection?.count ?? 0
        }
        else{
            return 0
        }
        
    }
    
    
    func getCellData(section: Int, row: Int) -> ItemDetails {
        
        
        let sectionTitleName = headerTitles[section]
        
        
        if sectionTitleName == "song" {
            let selectedItem = ItemDetails.init(artistName: sortedResults?.songSection?[row].artistName ?? "no value", primaryGenreName: sortedResults?.songSection?[row].primaryGenreName, artworkUrl: sortedResults?.songSection?[row].artworkUrl ?? "no value", trackViewURL: sortedResults?.songSection?[row].trackViewURL ?? "no value")
            return selectedItem
        }
        if sectionTitleName == "podcast" {
            let selectedItem = ItemDetails.init(artistName: sortedResults?.podcastSection?[row].artistName, primaryGenreName: sortedResults?.tvEpisodeSection?[row].primaryGenreName, artworkUrl: sortedResults?.podcastSection?[row].artworkUrl, trackViewURL: sortedResults?.podcastSection?[row].trackViewURL)
            return selectedItem
        }
        if sectionTitleName == "tv-episode" {
            
            let selectedItem = ItemDetails.init(artistName: sortedResults?.tvEpisodeSection?[row].artistName, primaryGenreName: sortedResults?.tvEpisodeSection?[row].primaryGenreName, artworkUrl: sortedResults?.tvEpisodeSection?[row].artworkUrl, trackViewURL: sortedResults?.tvEpisodeSection?[row].trackViewURL)
            return selectedItem
        }
        if sectionTitleName == "book" {
            let selectedItem = ItemDetails.init(artistName: sortedResults?.bookSection?[row].artistName, primaryGenreName: sortedResults?.bookSection?[row].primaryGenreName, artworkUrl: sortedResults?.bookSection?[row].artworkUrl, trackViewURL: sortedResults?.bookSection?[row].trackViewURL)
            return selectedItem
        }
        if sectionTitleName == "album" {
            let selectedItem = ItemDetails.init(artistName: sortedResults?.albumSection?[row].artistName, primaryGenreName: sortedResults?.albumSection?[row].primaryGenreName, artworkUrl: sortedResults?.albumSection?[row].artworkUrl, trackViewURL: sortedResults?.albumSection?[row].trackViewURL)
            return selectedItem
            
        }
        if sectionTitleName == "coached-audio" {
            let selectedItem = ItemDetails.init(artistName: sortedResults?.coachedAudioSection?[row].artistName, primaryGenreName: sortedResults?.coachedAudioSection?[row].primaryGenreName, artworkUrl: sortedResults?.coachedAudioSection?[row].artworkUrl, trackViewURL: sortedResults?.coachedAudioSection?[row].trackViewURL)
            return selectedItem
        }
        if sectionTitleName == "interactive-booklet" {
            let selectedItem = ItemDetails.init(artistName: sortedResults?.interactiveBookletArraySection?[row].artistName, primaryGenreName: sortedResults?.interactiveBookletArraySection?[row].primaryGenreName, artworkUrl: sortedResults?.interactiveBookletArraySection?[row].artworkUrl, trackViewURL: sortedResults?.interactiveBookletArraySection?[row].trackViewURL)
            return selectedItem
        }
        if sectionTitleName == "music-video" {
            let selectedItem = ItemDetails.init(artistName: sortedResults?.musicVideoSection?[row].artistName, primaryGenreName: sortedResults?.musicVideoSection?[row].primaryGenreName, artworkUrl: sortedResults?.musicVideoSection?[row].artworkUrl, trackViewURL: sortedResults?.musicVideoSection?[row].trackViewURL)
            return selectedItem
        }
        if sectionTitleName == "pdf" {
            let selectedItem = ItemDetails.init(artistName: sortedResults?.pdfSection?[row].artistName, primaryGenreName: sortedResults?.pdfSection?[row].primaryGenreName, artworkUrl: sortedResults?.pdfSection?[row].artworkUrl, trackViewURL: sortedResults?.pdfSection?[row].trackViewURL)
            return selectedItem
        }
        if sectionTitleName == "podcast-episode" {
            let selectedItem = ItemDetails.init(artistName: sortedResults?.podcastEpisodeSection?[row].artistName, primaryGenreName: sortedResults?.podcastEpisodeSection?[row].primaryGenreName, artworkUrl: sortedResults?.podcastEpisodeSection?[row].artworkUrl, trackViewURL: sortedResults?.podcastEpisodeSection?[row].trackViewURL)
            return selectedItem
        }
        if sectionTitleName == "software-package" {
            let selectedItem = ItemDetails.init(artistName: sortedResults?.softwarePackageSection?[row].artistName, primaryGenreName: sortedResults?.softwarePackageSection?[row].primaryGenreName, artworkUrl: sortedResults?.softwarePackageSection?[row].artworkUrl, trackViewURL: sortedResults?.softwarePackageSection?[row].trackViewURL)
            return selectedItem
        }
        if sectionTitleName == "artist" {
            let selectedItem = ItemDetails.init(artistName: sortedResults?.artistSection?[row].artistName, primaryGenreName: sortedResults?.artistSection?[row].primaryGenreName, artworkUrl: sortedResults?.artistSection?[row].artworkUrl, trackViewURL: sortedResults?.artistSection?[row].trackViewURL)
            return selectedItem
        }
        if sectionTitleName == "feature-movie" {
            let selectedItem = ItemDetails.init(artistName: sortedResults?.featureMovieSection?[row].artistName, primaryGenreName: sortedResults?.featureMovieSection?[row].primaryGenreName, artworkUrl: sortedResults?.featureMovieSection?[row].artworkUrl, trackViewURL: sortedResults?.featureMovieSection?[row].trackViewURL)
            return selectedItem
        }
        else{
            let selectedItem = ItemDetails.init(artistName: "NO VALUE", primaryGenreName: "NO VALUE", artworkUrl: "NO VALUE", trackViewURL: "NO VALUE")
            return selectedItem
        }
    }
    
}


// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource  {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! CatalogTableViewCell
        let cellDetails = getCellData(section: indexPath.section, row: indexPath.row)
        cell.artistName.text = cellDetails.artistName
        cell.url.text = cellDetails.trackViewURL
        cell.genre.text = cellDetails.primaryGenreName
        
        if let url = URL(string: "\(cellDetails.artworkUrl ?? "" )") {
            
            getImageDataFromURL(url: url) { (data, _, error) in
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    cell.itemImage.image = image
                    //     cell.productImage.image = image
                }
                if error != nil {
                    print(error!)
                }
            }
        }
        return cell
    }
}


// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNumberOfRowsForEachSection(sectionNumber: section)
    }
    
}

//MARK: Image Download
extension ViewController {
    fileprivate func getImageDataFromURL(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
//MARK: Seach Bar
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("SEARCH CLICKED")
        let updatedString = searchBar.text?.replacingOccurrences(of: " ", with: "+")
        getDataAndParseJSON(searchString: updatedString ?? "")
        tableView.reloadData()
    }
    
}
