//
//  MovieViewController.swift
//  Pod 1
//
//  Created by sunqiao lin on 4/17/23.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []
    var searchedMovie = [Movie]()
    var searching = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchedMovie.count
        }
        else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        var movie = movies[indexPath.row]
        if searching {
            movie = searchedMovie[indexPath.row]
        }
        cell.configure(with: movie)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        //searchBar.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a136b2ec095d7de7faf378f9b590d450")!
        
        let request = URLRequest(url:url)
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            
            if let error = error {
                    print("❌ Network error: \(error.localizedDescription)")
                }
                // Make sure we have data
                guard let data = data else {
                    print("❌ Data is nil")
                    return
                }
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(MovieResponse.self, from:data)
                let movies = response.results
                
                DispatchQueue.main.async {
                    self?.movies = movies
                    self?.tableView.reloadData()
                }
                print("✅ \(movies)")
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
           
        }
        task.resume()
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell,
           
            let indexPath = tableView.indexPath(for: cell),
           
            let detailViewController = segue.destination as? DetailViewController1{
            let movie = movies[indexPath.row]
            
            detailViewController.movie = movie
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow{
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @IBAction func onLogOutTapped(_ sender: Any) {
        showConfirmLogoutAlert()
    }
    private func showConfirmLogoutAlert() {
        let alertController = UIAlertController(title: "Log out of your account?", message: nil, preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

extension MovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedMovie = movies.filter { $0.original_title.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()

    }
}
