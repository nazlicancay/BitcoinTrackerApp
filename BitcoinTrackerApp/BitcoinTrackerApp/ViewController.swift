//
//  ViewController.swift
//  BitcoinTrackerApp
//
//  Created by Nazlıcan Çay on 15.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bitcoinPrice: UILabel!
    
    @IBOutlet weak var etherPrice: UILabel!
    
    @IBOutlet weak var dolarPrice: UILabel!
    
    @IBOutlet weak var lastUpdated: UILabel!
    
    let urlString = "https://api.coingecko.com/api/v3/exchange_rates"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private func fetchData( ){
        
        let url = URL(string: urlString)
        let defaultSession =  URLSession(configuration: .default)
        let dataTask = defaultSession.dataTask(with: url!){(data: Data? , responds :URLResponse? ,error :Error?) in
            
            if(error != nil){
                print(error)
                return
            }
            
            do{
                let json = try JSONDecoder().decode(Rates.self, from: data!)
                self.setPrice(currency: json.rates)
            }
            catch {
                print(error)
                return
            }
                
        }
        dataTask.resume()
        
        
    }
    private func setPrice( currency : Currency){
        
        DispatchQueue.main.async {

        self.bitcoinPrice.text = self.PriceFormat(currency.btc)
        self.etherPrice.text = self.PriceFormat(currency.eth)
        self.dolarPrice.text = self.PriceFormat(currency.usd)
        self.lastUpdated.text = self.dateFormatter(date: Date())
            
        }
       

    }
    
    private func PriceFormat(_ price: Price) -> String {
        
        return String (format: "%@ %.2f", price.unit , price.value)
    }
    
    private func dateFormatter( date : Date) ->String {
        
         let formatter = DateFormatter()
        formatter.dateFormat = "dd MM y HH:mm"
        return formatter.string(from: date)
        
        
    }
    


}

