//
//  Track.swift
//  Pod 1
//
//  Created by Naomi Wu on 4/24/23.
//

import Foundation

struct TracksResponse:Decodable {
    let showtimes: [Showtime]
}

struct ThreaterResponse:Decodable{
    let Threaters: [Track]
}

struct Showtime:Decodable{
    let day: String
    let date: String
    let theaters: [Track]
}

struct Track:Decodable {
    let name: String
    let distance: String
    let address: String
    let showing: [Time]
}

struct Time: Decodable{
    let time: [String]
}
