//
//  ThreaterViewController.swift
//  Pod 1
//
//  Created by sunqiao lin on 4/25/23.
//

import UIKit

class ThreaterViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThreaterCell", for: indexPath) as! ThreaterCell
        
        let track = tracks[indexPath.row]
        
        cell.configure(with: track)
        
        return cell
    }
    
  
    @IBOutlet weak var CurrentLocation: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var tracks: [Track] = []
    
    var times: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    


                }
               // print("✅ \(String(describing: self?.times))")
            } catch {
                print("❌ Error parsing JSON: \(error)")
            }
        }

        // Initiate the network request
        task.resume()

        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

