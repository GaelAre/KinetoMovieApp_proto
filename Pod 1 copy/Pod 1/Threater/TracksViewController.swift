//
//  TracksViewController.swift
//  Pod 1
//
//  Created by Naomi Wu on 4/24/23.
//

import UIKit

class TracksViewController: UIViewController, UITableViewDataSource {

    var tracks: [Track] = []
    
    var times: [String] = []

    @IBOutlet weak var CurrentLocation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Pt 1 - Set tracks property with mock tracks array
        // Create a URL for the request
        // In this case, the custom search URL you created in in part 1
        CurrentLocation.text = "Your current location is Evanston, IL"
        let url = URL(string: "https://serpapi.com/search.json?q=mario+theater&location=Evanston,+Illinois,+United+States&hl=en&gl=us&google_domain=google.com&api_key=666bd4c236607c71abb891b7ce074904e0677e1c51fe079c13262c4d559599c3")!

        // Use the URL to instantiate a request
        let request = URLRequest(url: url)

        // Create a URLSession using a shared instance and call its dataTask method
        // The data task method attempts to retrieve the contents of a URL based on the specified URL.
        // When finished, it calls it's completion handler (closure) passing in optional values for data (the data we want to fetch), response (info about the response like status code) and error (if the request was unsuccessful)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }

            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }

            // The `JSONSerialization.jsonObject(with: data)` method is a "throwing" function (meaning it can throw an error) so we wrap it in a `do` `catch`
            // We cast the resultant returned object to a dictionary with a `String` key, `Any` value pair.
            do {
                // Create a JSON Decoder
                let decoder = JSONDecoder()

                // Use the JSON decoder to try and map the data to our custom model.
                // TrackResponse.self is a reference to the type itself, tells the decoder what to map to.
                let response = try decoder.decode(TracksResponse.self, from: data)
//                let response2 = try decoder.decode(.self, from: data)

//                print(response.showtimes[0].theaters[0].showing[0].time)

                // Access the array of tracks from the `results` property
                let track = response.showtimes
//                let times = response.
                DispatchQueue.main.async {

                    // Set the view controller's tracks property as this is the one the table view references
                    self?.tracks = track.flatMap { $0.theaters }

                    // Make the table view reload now that we have new data
                    self?.tableView.reloadData()
                    
                    var timesarray: [String] = []

                    for theater in track[0].theaters {
                        for showing in theater.showing {
                            timesarray.append(contentsOf: showing.time)
                        }
                    }
                    
                    self?.times = timesarray
                    print(timesarray)

                }
                print("✅ \(String(describing: self?.times))")
            } catch {
                print("❌ Error parsing JSON: \(error)")
            }
        }

        // Initiate the network request
        task.resume()

        tableView.dataSource = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // TODO: Deselect any selected table view rows

        // Get the index path for the current selected table view row (if exists)
        if let indexPath = tableView.indexPathForSelectedRow {

            // Deslect the row at the corresponding index path
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Pt 1 - Pass the selected track to the detail view controller

        // Get the cell that triggered the segue
        if let cell = sender as? UITableViewCell,
           // Get the index path of the cell from the table view
           let indexPath = tableView.indexPath(for: cell),
           // Get the detail view controller
           let detailViewController = segue.destination as? DetailViewController {

            // Use the index path to get the associated track
            let track = tracks[indexPath.row]

            // Set the track on the detail view controller
            detailViewController.track = track
            
            detailViewController.time = times
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Get a cell with identifier, "TrackCell"
        // the `dequeueReusableCell(withIdentifier:)` method just returns a generic UITableViewCell so it's necessary to cast it to our specific custom cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell

        // Get the track that corresponds to the table view row
        let track = tracks[indexPath.row]

        // Configure the cell with it's associated track
        cell.configure(with: track)

        // return the cell for display in the table view
        return cell
    }
}

