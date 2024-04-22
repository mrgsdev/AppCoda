//
//  KivaLoanTableViewController.swift
//  Chapter 4
//
//  Created by mrgsdev on 22.04.2024.
//

import UIKit

class KivaLoanTableViewController: UITableViewController {

    enum Section {
        case all
    }
    
    private let kivaLoanURL = "https://api.kivaws.org/v1/loans/newest.json"
    private var loans = [Loan]()
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 92.0
        tableView.rowHeight = UITableView.automaticDimension
        
        getLatestLoans()
    }

   
    
}
extension KivaLoanTableViewController{
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Loan> {

        let cellIdentifier = "Cell"

        let dataSource = UITableViewDiffableDataSource<Section, Loan>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, loan in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! KivaLoanTableViewCell

                cell.nameLabel.text = loan.name
                cell.countryLabel.text = loan.country
                cell.useLabel.text = loan.use
                cell.amountLabel.text = "$\(loan.amount)"

                return cell
            }
        )

        return dataSource
    }

    func updateSnapshot(animatingChange: Bool = false) {

        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Loan>()
        snapshot.appendSections([.all])
        snapshot.appendItems(loans, toSection: .all)

        dataSource.apply(snapshot, animatingDifferences: animatingChange)
    }
}

extension KivaLoanTableViewController  {
    func getLatestLoans() {
        guard let loanUrl = URL(string: kivaLoanURL) else {
            return
        }
        
        let request = URLRequest(url: loanUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            // Parse JSON data
            if let data = data {
                self.loans = self.parseJsonData(data: data)
                
                // Update table view's data
                OperationQueue.main.addOperation({
                    self.updateSnapshot()
                })
            }
        })
        
        task.resume()
    }

    func parseJsonData(data: Data) -> [Loan] {
        
        var loans = [Loan]()
        
        let decoder = JSONDecoder()
        
        do {
            let loanDataStore = try decoder.decode(LoanDataStore.self, from: data)
            loans = loanDataStore.loans
            
        } catch {
            print(error)
        }
        
        return loans
    }
    
}
