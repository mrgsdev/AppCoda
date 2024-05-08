//
//  HotelTableViewController.swift
//  Chapter 25
//
//  Created by mrgsdev on 06.05.2024.
//

import UIKit

class HotelTableViewController: UITableViewController {

    private var hotels:[(name: String, address: String, description: String)] = [("Hatcher's Manor", "73 Prossers Road, Richmond, Clarence, Tasmania 7025, Australia", "Experience luxurious accommodation set amongst our 100 acre working farm and orchard on the beautiful Coal River just 20 Minutes from Hobart. Woodburn Farm is one of Tasmania's most historical farms. Granted to Gilbert Robertson, the Chief Constable of the Coal River area in the 1820's. Land for St Johns Church (the oldest Catholic Church in Australia) was donated by the second owner of Woodburn, Mr John Cassidy in the 1830's."),
        ("The Grand Del Mar", "5300 Grand Del Mar Court, San Diego, CA 92130", "In 2014, The Grand Del Mar achieved the esteemed distinction of #1 Hotel in the United States  (#14 worldwide) and #1 Luxury Hotel in the United States (#11 worldwide) as awarded by prominent travel authority, TripAdvisor. This accomplishment follows a growing list of prestigious accolades: California’s #1 Resort in Travel + Leisure’s 2013 World’s Best Awards and California’s first triple Five-Star resort in 2012 receiving Forbes Travel Guide’s highest rating for its hotel, spa and restaurant – an honor held by only 10 destinations in the world."),
        ("French Quarter Inn", "166 Church St, Charleston, SC 29401", "The French Quarter Inn overlooks the historic Charleston City Market. Newly renovated the market has been serving the Holy City since 1807. Wander through rows of stalls featuring Charleston souvenirs, interesting finds and works by local artisans including famous Lowcountry sweetgrass baskets. Stop into the new air conditioned Great Hall that features boutique shopping and gourmet food."),
        ("Clarion Hotel City Park Grand", "22 Tamar Street, Launceston, Tasmania 7250, Australia", "The Clarion Hotel City Park Grand is an icon of affordable luxury accommodations and Tasmanian hospitality. The hotel is ideally located in downtown Launceston, adjacent to the beautiful City Park that features Japanese Macaque monkeys, beautiful gardens blooming with color, playgrounds and more. Popular attractions like the Queen Victoria Museum and Art Gallery, Aurora Stadium, Boags Brewery and many other local points of interest are nearby."),
        ("The Henry Jones Art Hotel", "25 Hunter Street, Hobart, Tasmania 7000, Australia", "The Henry Jones Art Hotel is a fusion of history and modernity, art and design, indulgence and discovery. Australia’s first dedicated art hotel, The Henry Jones merges one of Tasmania’s most significant industrial heritage sites—H. Jones and Co. Pty. Ltd. IXL—with modern design and contemporary art to create a luxurious accommodation experience."),
        ("Hotel Yountville", "6462 Washington Street, Yountville, CA 94599", "Located right downtown in the intimate community of Yountville, the Hotel Yountville is set amidst the many world class restaurants, shops and wine tasting rooms. No need to get in your car- but rather take a casual stroll along the Oak lined streets when seeking out a memorable evening meal from a Michelin starred chef, the perfect breakfast pastry and coffee, light shopping in one of the many boutique shops or some additional wine tasting in one of the four wine tasting rooms."),
        ("Premier Inn Swansea Waterfront", "Waterfront Development, Langdon Rd, Swansea SA1 8PL, Wales", "It'll be a sailor's life for you at the Premier Inn Hotel Swansea Waterfront. Slap bang on the marina with views of the sea and surrounding hills, you'll find a shipshape spot for a relaxing stay."),
        ("Bardessono", "6526 Yount Street, Yountville, CA 94599", "With our LEED Platinum certification, Bardessono is a 100% non-smoking property, inside and outside. This includes a ban on electronic cigarettes, as well. While we love all our guests, we put the needs of the environment first."),
        ("Islington Hotel", "321 Davey Street, Hobart, Tasmania 7000, Australia", "Islington is a very special, small, luxe hotel in Hobart with a long history and a large delightful garden, affording unique and stunning views of Mount Wellington. Decorated with fine art and furnished with antiques, Islington appeals to those who desire the very best in life. Surrounded by personalised service, presented in an atmosphere of serenity, luxury and tranquility.")]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 95.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return hotels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HotelTableViewCell

        // Configure the cell...
        let hotel = hotels[indexPath.row]
        cell.nameLabel.text = hotel.name
        cell.addressLabel.text = hotel.address
        cell.descriptionLabel.text = hotel.description

        return cell
    }
    


}
