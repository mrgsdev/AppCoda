//
//  Photo.swift
//  Chapter 40
//
//  Created by mrgsdev on 20.10.2024.
//


import SwiftUI

struct Photo: Identifiable {
    var id = UUID()
    var image: Image
    var caption: String
    var description: String
}

extension Photo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }
}

let photos = [
    Photo(image: Image("bigben"), caption: "Big Ben", description: "Big Ben is the nickname for the Great Bell of the striking clock at the north end of the Palace of Westminster in London, England, and the name is frequently extended to refer also to the clock and the clock tower."),
    Photo(image: Image("bridge"), caption: "Sydney Harbour Bridge", description: "The Sydney Harbour Bridge is a steel through arch bridge in Sydney, spanning Sydney Harbour from the central business district (CBD) to the North Shore. The view of the bridge, the harbour, and the nearby Sydney Opera House is widely regarded as an iconic image of Sydney, and of Australia itself. "),
    Photo(image: Image("flatiron"), caption: "Flatiron Building", description: "The Flatiron Building, originally the Fuller Building, is a triangular 22-story, 285-foot-tall (86.9 m) steel-framed landmarked building located at 175 Fifth Avenue in the eponymous Flatiron District neighborhood of the borough of Manhattan, New York City."),
]
